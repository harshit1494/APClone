import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';
import '../utils/app_color.dart';
import '../utils/app_images.dart';
import '../utils/app_utils.dart';
import '../widgets/custom_text_widget.dart';
import '../widgets/label_border_text_widget.dart';
import '../widgets/circular_button_toggle_widget.dart';
import '../widgets/order_row_widget.dart';
import '../models/order_model.dart';
import 'dart:math' as math;

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final ValueNotifier<int> _selectedOrderStatusIndex = ValueNotifier<int>(0);
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchSelected = false;
  bool _isFilterSelected = false;

  final List<String> _orderStatusFilter = ['All', 'Open', 'Closed'];
  final List<String> _orderStatusCountFilter = ['0', '0', '0'];

  // Dummy orders data
  final List<Order> _allOrders = [
    Order(
      ordId: '1',
      sym: 'RELIANCE',
      dispSym: 'RELIANCE',
      baseSym: 'RELIANCE',
      exc: 'NSE',
      prdType: 'Cash',
      ordType: 'Market',
      ordAction: 'Buy',
      status: 'Executed',
      qty: '10',
      tradedQty: '10',
      limitPrice: null,
      avgPrice: '2450.50',
      ltp: '2455.00',
      ordDate: '15-01-2024 10:30:45',
      isAmo: false,
      isBasket: false,
    ),
    Order(
      ordId: '2',
      sym: 'TCS',
      dispSym: 'TCS',
      baseSym: 'TCS',
      exc: 'NSE',
      prdType: 'Cash',
      ordType: 'Limit',
      ordAction: 'Sell',
      status: 'Pending',
      qty: '5',
      tradedQty: '0',
      limitPrice: '3850.00',
      avgPrice: null,
      ltp: '3845.00',
      ordDate: '15-01-2024 11:15:20',
      isAmo: false,
      isBasket: false,
    ),
    Order(
      ordId: '3',
      sym: 'INFY',
      dispSym: 'INFY',
      baseSym: 'INFY',
      exc: 'NSE',
      prdType: 'Cash',
      ordType: 'Market',
      ordAction: 'Buy',
      status: 'Executed',
      qty: '15',
      tradedQty: '15',
      limitPrice: null,
      avgPrice: '1520.75',
      ltp: '1525.00',
      ordDate: '15-01-2024 09:45:30',
      isAmo: true,
      isBasket: false,
    ),
    Order(
      ordId: '4',
      sym: 'HDFCBANK',
      dispSym: 'HDFCBANK',
      baseSym: 'HDFCBANK',
      exc: 'NSE',
      prdType: 'Cash',
      ordType: 'Limit',
      ordAction: 'Sell',
      status: 'Rejected',
      qty: '8',
      tradedQty: '0',
      limitPrice: '1650.00',
      avgPrice: null,
      ltp: '1645.00',
      ordDate: '14-01-2024 14:20:10',
      isAmo: false,
      isBasket: false,
    ),
  ];

  List<Order> get _filteredOrders {
    if (_selectedOrderStatusIndex.value == 0) {
      return _allOrders;
    } else if (_selectedOrderStatusIndex.value == 1) {
      return _allOrders.where((order) => order.status?.toLowerCase() == 'pending').toList();
    } else {
      return _allOrders.where((order) => order.status?.toLowerCase() != 'pending').toList();
    }
  }

  @override
  void initState() {
    super.initState();
    _updateOrderCounts();
  }

  void _updateOrderCounts() {
    final allCount = _allOrders.length.toString();
    final openCount = _allOrders.where((o) => o.status?.toLowerCase() == 'pending').length.toString();
    final closedCount = _allOrders.where((o) => o.status?.toLowerCase() != 'pending').length.toString();
    
    _orderStatusCountFilter[0] = allCount;
    _orderStatusCountFilter[1] = openCount;
    _orderStatusCountFilter[2] = closedCount;
  }

  @override
  void dispose() {
    _selectedOrderStatusIndex.dispose();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: RefreshIndicator(
          onRefresh: () async {
            // Refresh orders
            setState(() {});
          },
          child: _buildBodyContent(context),
        ),
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppWidgetSize.dimen_15,
        left: AppWidgetSize.dimen_24,
        right: AppWidgetSize.dimen_24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_isSearchSelected)
            _buildSearchTextBox(context)
          else
            _buildToolBarWidget(context),
          if (!_isSearchSelected) _buildOrderStatusWidget(context),
          _buildOrderbookContentWidget(context),
        ],
      ),
    );
  }

  Widget _buildToolBarWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTradeHistory(context),
                if (_hasPendingOrders()) _buildCancelAll(context),
              ],
            ),
          ),
        ),
        IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  _showMyOrdersInfoBottomSheet(context);
                },
                child: AppImages.informationIcon(
                  context,
                  width: AppWidgetSize.dimen_30,
                  height: AppWidgetSize.dimen_30,
                  color: Theme.of(context).primaryIconTheme.color,
                  isColor: true,
                ),
              ),
              _buildFilter(context),
              _buildSearch(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTradeHistory(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: AppWidgetSize.dimen_5),
      margin: EdgeInsets.only(right: AppWidgetSize.dimen_5),
      child: LabelBorderWidget(
        text: 'Trade History',
        textColor: Theme.of(context).primaryColor,
        fontSize: AppWidgetSize.fontSize14,
        borderRadius: AppWidgetSize.dimen_24,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        borderWidth: 1,
        borderColor: Theme.of(context).dividerColor,
        padding: EdgeInsets.symmetric(
          horizontal: AppWidgetSize.dimen_6,
          vertical: AppWidgetSize.dimen_5,
        ),
        onTap: () {
          // Handle trade history tap
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppImages.tradeHistory(
              context,
              width: AppWidgetSize.dimen_12,
              height: AppWidgetSize.dimen_12,
            ),
            SizedBox(width: AppWidgetSize.dimen_3),
            CustomTextWidget(
              'Trade History',
              Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: AppWidgetSize.fontSize12,
                  ) ?? TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: AppWidgetSize.fontSize12,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCancelAll(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: AppWidgetSize.dimen_5),
      margin: EdgeInsets.only(right: AppWidgetSize.dimen_5),
      child: LabelBorderWidget(
        text: 'Cancel Orders',
        textColor: Theme.of(context).primaryColor,
        fontSize: AppWidgetSize.fontSize14,
        borderRadius: AppWidgetSize.dimen_24,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        borderWidth: 1,
        borderColor: Theme.of(context).dividerColor,
        padding: EdgeInsets.symmetric(
          horizontal: AppWidgetSize.dimen_6,
          vertical: AppWidgetSize.dimen_5,
        ),
        onTap: () {
          // Handle cancel all tap
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppImages.closeCross(
              context,
              width: AppWidgetSize.dimen_12,
              height: AppWidgetSize.dimen_12,
              color: Theme.of(context).primaryColor,
              isColor: true,
            ),
            SizedBox(width: AppWidgetSize.dimen_3),
            CustomTextWidget(
              'Cancel Orders',
              Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: AppWidgetSize.fontSize12,
                  ) ?? TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: AppWidgetSize.fontSize12,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilter(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isFilterSelected = !_isFilterSelected;
        });
        // Handle filter tap
      },
      child: Padding(
        padding: EdgeInsets.only(
          right: AppWidgetSize.dimen_4,
          left: AppWidgetSize.dimen_4,
        ),
        child: AppUtils().buildFilterIcon(
          context,
          isSelected: _isFilterSelected,
        ),
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isSearchSelected = true;
        });
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: AppWidgetSize.dimen_4,
        ),
        child: AppImages.searchIcon(
          context,
          width: AppWidgetSize.dimen_24,
          height: AppWidgetSize.dimen_24,
          color: Theme.of(context).primaryIconTheme.color,
          isColor: true,
        ),
      ),
    );
  }

  Widget _buildSearchTextBox(BuildContext context) {
    return Container(
      height: AppWidgetSize.dimen_40,
      decoration: BoxDecoration(
        color: Theme.of(context).inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: AppWidgetSize.dimen_10),
      child: Stack(
        children: [
          TextField(
            controller: _searchController,
            cursorColor: Theme.of(context).iconTheme.color,
            enableInteractiveSelection: true,
            autocorrect: false,
            enabled: true,
            textCapitalization: TextCapitalization.characters,
            onChanged: (String text) {
              setState(() {});
            },
            textInputAction: TextInputAction.done,
            style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.only(
                top: AppWidgetSize.dimen_10,
                bottom: AppWidgetSize.dimen_7,
                right: AppWidgetSize.dimen_10,
              ),
              hintText: 'Search symbol',
              hintStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).dialogTheme.backgroundColor?.withAlpha(100),
              ),
              counterText: '',
            ),
            maxLength: 25,
          ),
          Positioned(
            right: 0,
            top: AppWidgetSize.dimen_12,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isSearchSelected = false;
                  _searchController.text = '';
                });
              },
              child: Center(
                child: AppImages.deleteIcon(
                  context,
                  width: AppWidgetSize.dimen_25,
                  height: AppWidgetSize.dimen_25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStatusWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppWidgetSize.dimen_10,
        bottom: AppWidgetSize.dimen_5,
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: AppWidgetSize.dimen_40,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ValueListenableBuilder<int>(
                      valueListenable: _selectedOrderStatusIndex,
                      builder: (context, value, child) => CircularButtonToggleWidget(
                        value: _orderStatusFilter[value],
                        buttonNoList: _orderStatusCountFilter,
                        toggleButtonlist: _orderStatusFilter,
                        toggleButtonOnChanged: (String selectedLabel) {
                          final index = _orderStatusFilter.indexOf(selectedLabel);
                          if (index != -1) {
                            _selectedOrderStatusIndex.value = index;
                          }
                        },
                        inactiveButtonColor: Colors.transparent,
                        activeButtonColor: Theme.of(context)
                            .snackBarTheme
                            .backgroundColor!
                            .withOpacity(0.5),
                        inactiveTextColor: Theme.of(context).primaryColor,
                        activeTextColor: Theme.of(context).primaryColor,
                        isBorder: false,
                        borderColor: Colors.transparent,
                        paddingEdgeInsets: EdgeInsets.fromLTRB(
                          AppWidgetSize.dimen_12,
                          AppWidgetSize.dimen_6,
                          AppWidgetSize.dimen_12,
                          AppWidgetSize.dimen_6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _showSettingsBottomSheet(context);
            },
            child: AppImages.ordersSettings(
              context,
              color: Theme.of(context).primaryIconTheme.color,
              isColor: true,
              width: 24.w,
              height: 24.w,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderbookContentWidget(BuildContext context) {
    final orders = _filteredOrders;
    
    if (orders.isEmpty) {
      return Expanded(
        child: Center(
          child: CustomTextWidget(
            'No orders found',
            Theme.of(context).textTheme.displayMedium!,
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: orders.length,
        padding: EdgeInsets.only(bottom: AppWidgetSize.dimen_10),
        itemBuilder: (context, int index) {
          return OrderRowWidget(
            order: orders[index],
            isLastIndex: index == orders.length - 1,
            onRowClick: (Order selected) {
              // Handle order row click
            },
          );
        },
      ),
    );
  }

  bool _hasPendingOrders() {
    return _allOrders.any((order) => order.status?.toLowerCase() == 'pending');
  }

  void _showMyOrdersInfoBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.w)),
      ),
      builder: (BuildContext bct) {
        return Container(
          padding: EdgeInsets.all(AppWidgetSize.dimen_20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextWidget(
                    'My Orders',
                    Theme.of(context).primaryTextTheme.titleMedium!,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: AppImages.closeIcon(
                      context,
                      width: 20.w,
                      height: 20.w,
                    ),
                  ),
                ],
              ),
              Divider(thickness: 1, color: Theme.of(context).dividerColor),
              SizedBox(height: AppWidgetSize.dimen_10),
              CustomTextWidget(
                'Order information will be displayed here.',
                Theme.of(context).textTheme.bodyMedium!,
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSettingsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.w)),
      ),
      builder: (BuildContext bct) {
        return Container(
          padding: EdgeInsets.all(AppWidgetSize.dimen_20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                'Order Settings',
                Theme.of(context).primaryTextTheme.titleMedium!,
              ),
              Divider(thickness: 1, color: Theme.of(context).dividerColor),
              SizedBox(height: AppWidgetSize.dimen_10),
              CustomTextWidget(
                'Settings options will be displayed here.',
                Theme.of(context).textTheme.bodyMedium!,
              ),
            ],
          ),
        );
      },
    );
  }
}
