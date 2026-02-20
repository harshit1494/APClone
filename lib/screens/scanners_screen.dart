import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';
import '../utils/app_color.dart';
import '../utils/app_images.dart';
import '../widgets/custom_text_widget.dart';
import '../widgets/circular_button_toggle_widget.dart';
import '../widgets/info_bottomsheet.dart';

class ScannersScreen extends StatefulWidget {
  const ScannersScreen({Key? key}) : super(key: key);

  @override
  State<ScannersScreen> createState() => _ScannersScreenState();
}

class _ScannersScreenState extends State<ScannersScreen> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _topContentScrollController = ScrollController();
  
  int _selectedTabIndex = 0;
  int _selectedNseBseIndex = 0; // 0 = NSE, 1 = BSE
  int _selectedIndexFilter = 1; // Default to NIFTY 100
  String _selectedScannerType = 'Bullish breakout'; // For Custom Scanners
  String _selectedSmaType = '5 SMA'; // For SMA/EMA
  String _selectedSmaForCustom = '5 SMA'; // For 5 SMA dropdown in Custom Scanners
  
  final List<String> _bullishItems = [
    'Custom Scanners',
    'SMA/EMA',
    'RSI',
    'Parabolic SAR',
    'Bollinger Bands',
    'MACD',
    'Williams %R',
  ];

  // Dummy indices list for NSE
  final List<String> _nseIndices = [
    'NIFTY 50',
    'NIFTY 100',
    'BANKNIFTY',
    'NIFTY IT',
    'NIFTY MIDCAP 100',
    'NIFTY NEXT 50',
  ];

  // Dummy indices list for BSE
  final List<String> _bseIndices = [
    'SENSEX',
    'BSE 100',
    'BSE 200',
    'BSE 500',
  ];

  // Scanner types for Custom Scanners
  final List<String> _customScannerTypes = [
    'Bullish breakout',
    'Bearish breakout',
    'Golden Crossover Bullish',
    'Golden Crossover Bearish',
  ];

  // SMA types for SMA/EMA
  final List<String> _smaTypes = [
    '5 SMA',
    '10 SMA',
    '20 SMA',
    '30 SMA',
    '50 SMA',
  ];

  // Get header list - only Symbol, ADX, and 5 SMA
  List<Map<String, String>> get _headerList {
    return [
      {'key': 'SYMBOL', 'label': 'Scrip', 'sort': 'none'},
      {'key': 'ADX25', 'label': 'ADX', 'sort': 'none'},
      {'key': 'SMA5', 'label': '5 SMA', 'sort': 'none'},
    ];
  }

  // Dummy scanner data with ADX and 5SMA
  final List<Map<String, dynamic>> _scannerData = [
    {
      'baseSym': 'RELIANCE',
      'dispSym': 'RELIANCE',
      'ltp': '2,450.50',
      'chng': '+25.50',
      'chngPer': '+1.05',
      'exc': 'NSE',
      'ADX25': '28.5',
      'SMA5': '2,425.00',
    },
    {
      'baseSym': 'TCS',
      'dispSym': 'TCS',
      'ltp': '3,245.75',
      'chng': '-15.25',
      'chngPer': '-0.47',
      'exc': 'NSE',
      'ADX25': '32.1',
      'SMA5': '3,260.00',
    },
    {
      'baseSym': 'HDFCBANK',
      'dispSym': 'HDFCBANK',
      'ltp': '1,650.00',
      'chng': '+12.50',
      'chngPer': '+0.76',
      'exc': 'NSE',
      'ADX25': '25.8',
      'SMA5': '1,637.50',
    },
    {
      'baseSym': 'INFY',
      'dispSym': 'INFY',
      'ltp': '1,425.30',
      'chng': '-8.20',
      'chngPer': '-0.57',
      'exc': 'NSE',
      'ADX25': '30.2',
      'SMA5': '1,433.50',
    },
    {
      'baseSym': 'ICICIBANK',
      'dispSym': 'ICICIBANK',
      'ltp': '985.50',
      'chng': '+5.25',
      'chngPer': '+0.54',
      'exc': 'NSE',
      'ADX25': '27.9',
      'SMA5': '980.25',
    },
    {
      'baseSym': 'HINDUNILVR',
      'dispSym': 'HINDUNILVR',
      'ltp': '2,680.00',
      'chng': '+18.00',
      'chngPer': '+0.68',
      'exc': 'NSE',
      'ADX25': '29.5',
      'SMA5': '2,662.00',
    },
    {
      'baseSym': 'BHARTIARTL',
      'dispSym': 'BHARTIARTL',
      'ltp': '1,125.50',
      'chng': '+7.25',
      'chngPer': '+0.65',
      'exc': 'NSE',
      'ADX25': '26.3',
      'SMA5': '1,118.25',
    },
    {
      'baseSym': 'SBIN',
      'dispSym': 'SBIN',
      'ltp': '625.75',
      'chng': '-3.50',
      'chngPer': '-0.56',
      'exc': 'NSE',
      'ADX25': '31.7',
      'SMA5': '629.25',
    },
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    _topContentScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // Toggle Buttons
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: AppWidgetSize.dimen_10,
                left: AppWidgetSize.dimen_16,
                right: AppWidgetSize.dimen_16,
              ),
              child: SingleChildScrollView(
                controller: _topContentScrollController,
                scrollDirection: Axis.horizontal,
                child: CircularButtonToggleWidget(
                  value: _bullishItems[_selectedTabIndex],
                  toggleButtonlist: _bullishItems,
                  toggleButtonOnChanged: (String value) {
                    setState(() {
                      _selectedTabIndex = _bullishItems.indexOf(value);
                    });
                  },
                  activeButtonColor: isLight
                      ? Theme.of(context)
                          .snackBarTheme
                          .backgroundColor!
                          .withOpacity(0.5)
                      : Theme.of(context).primaryColor,
                  activeTextColor: isLight
                      ? Theme.of(context).primaryColor
                      : AppColors.primaryColorLight(false),
                  inactiveButtonColor: Colors.transparent,
                  inactiveTextColor:
                      Theme.of(context).primaryTextTheme.labelSmall!.color!,
                  borderColor: Theme.of(context)
                      .snackBarTheme
                      .backgroundColor!
                      .withOpacity(0.5),
                  fontSize: 15,
                  spacing: 8,
                ),
              ),
            ),
          ),
          
          // Filter Strip with dropdowns and filter icon
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppWidgetSize.dimen_16),
              child: Container(
                height: 48.w,
                child: Row(
                  children: [
                    // Custom Scanners dropdown (only for Custom Scanners tab) - extreme left
                    if (_selectedTabIndex == 0) ...[
                      // Bullish breakout dropdown
                      _buildScannerDropdown(
                        _selectedScannerType,
                        _customScannerTypes,
                        (value) {
                          setState(() {
                            _selectedScannerType = value;
                          });
                        },
                      ),
                      SizedBox(width: AppWidgetSize.dimen_8),
                      // 5 SMA dropdown
                      _buildScannerDropdown(
                        _selectedSmaForCustom,
                        _smaTypes,
                        (value) {
                          setState(() {
                            _selectedSmaForCustom = value;
                          });
                        },
                      ),
                    ],
                    // SMA/EMA dropdown (only for SMA/EMA tab) - extreme left
                    if (_selectedTabIndex == 1)
                      _buildScannerDropdown(
                        _selectedSmaType,
                        _smaTypes,
                        (value) {
                          setState(() {
                            _selectedSmaType = value;
                          });
                        },
                      ),
                    // Spacer to push filter icon to extreme right
                    const Spacer(),
                    // Filter icon in extreme right
                    _buildFilterIcon(),
                  ],
                ),
              ),
            ),
          ),
          
          // Sticky Header with NSE/BSE Toggle and Index Dropdown
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyHeaderDelegate(
              child: Padding(
                padding: EdgeInsets.only(
                  left: AppWidgetSize.dimen_16,
                  right: AppWidgetSize.dimen_16,
                  top: AppWidgetSize.dimen_4,
                  bottom: AppWidgetSize.dimen_8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildNseBseToggle(),
                    SizedBox(width: AppWidgetSize.dimen_12),
                    Expanded(child: _buildIndexDropdown()),
                  ],
                ),
              ),
            ),
          ),
          
          // Divider
          const SliverToBoxAdapter(
            child: Divider(thickness: 1, height: 1),
          ),
          
          // Table Header
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppWidgetSize.dimen_12,
                horizontal: AppWidgetSize.dimen_16,
              ),
              child: _buildTableHeader(),
            ),
          ),
          
          // Divider
          const SliverToBoxAdapter(
            child: Divider(thickness: 1, height: 1),
          ),
          
          // Scanner List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _buildScannerRow(_scannerData[index], index);
              },
              childCount: _scannerData.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScannerDropdown(
    String selectedValue,
    List<String> items,
    Function(String) onChanged,
  ) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      decoration: BoxDecoration(
        color: isLight ? AppColors.primaryColorLight(true) : null,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: isLight
              ? AppColors.primaryColorLight(true)
              : Theme.of(context).dividerColor,
          width: 1,
        ),
      ),
      child: OutlinedButton(
        onPressed: () {
          _showDropdownList(items, selectedValue, onChanged);
        },
        style: ButtonStyle(
          padding: const WidgetStatePropertyAll(EdgeInsets.all(8)),
          backgroundColor: WidgetStatePropertyAll(Colors.transparent),
          overlayColor: WidgetStatePropertyAll(
            Theme.of(context).dividerColor.withOpacity(0.1),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          ),
          side: WidgetStatePropertyAll(BorderSide.none),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextWidget(
              selectedValue,
              Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.w,
                  ) ??
                  Theme.of(context).textTheme.bodyLarge!,
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_outlined,
              color: Theme.of(context).textTheme.bodyLarge?.color,
              size: 16.w,
            ),
          ],
        ),
      ),
    );
  }

  void _showDropdownList(
    List<String> items,
    String selectedValue,
    Function(String) onChanged,
  ) {
    InfoBottomSheet.showInfoBottomsheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 20.w,
              left: 30.w,
              right: 30.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextWidget(
                  'Select',
                  Theme.of(context).primaryTextTheme.titleSmall!,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: AppImages.closeIcon(
                    context,
                    color: Theme.of(context).primaryIconTheme.color,
                    isColor: true,
                    width: AppWidgetSize.dimen_22,
                    height: AppWidgetSize.dimen_22,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              itemCount: items.length,
              separatorBuilder: (context, index) => Divider(
                thickness: 1,
                height: 1,
                color: Theme.of(context).dividerColor,
              ),
              itemBuilder: (context, index) {
                final isSelected = items[index] == selectedValue;
                return ListTile(
                  horizontalTitleGap: 2,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                  title: CustomTextWidget(
                    items[index],
                    Theme.of(context).primaryTextTheme.labelSmall?.copyWith(
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          fontSize: AppWidgetSize.fontSize16,
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : null,
                        ) ??
                        Theme.of(context).textTheme.bodyLarge!,
                  ),
                  trailing: isSelected
                      ? AppImages.greenTickIcon(
                          context,
                          width: AppWidgetSize.dimen_22,
                          height: AppWidgetSize.dimen_22,
                        )
                      : null,
                  onTap: () {
                    onChanged(items[index]);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        ],
      ),
      context,
      height: MediaQuery.of(context).size.height / 2.0,
      horizontalMargin: false,
    );
  }

  Widget _buildFilterIcon() {
    return Container(
      width: 50.w,
      height: 48.w,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: GestureDetector(
          onTap: () {
            // Handle filter
          },
          child: Transform.rotate(
            angle: 1.5708, // 90 degrees in radians (vertical)
            child: Icon(
              Icons.tune,
              size: 24,
              color: AppColors.primaryColor(Theme.of(context).brightness == Brightness.light),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNseBseToggle() {
    return Container(
      alignment: Alignment.centerRight,
      height: AppWidgetSize.dimen_38,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(AppWidgetSize.dimen_20),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppWidgetSize.dimen_2),
        child: ToggleButtons(
          onPressed: (int index) {
            setState(() {
              _selectedNseBseIndex = index;
              _selectedIndexFilter = index == 0 ? 1 : 0; // Reset to first index
            });
          },
          borderRadius: BorderRadius.all(
            Radius.circular(AppWidgetSize.dimen_20),
          ),
          selectedColor: Theme.of(context).colorScheme.secondary,
          renderBorder: false,
          fillColor: Theme.of(context).primaryTextTheme.displayLarge?.color ??
              Theme.of(context).textTheme.displayLarge?.color ??
              Colors.black,
          color: Theme.of(context).primaryTextTheme.displayLarge?.color ??
              Theme.of(context).textTheme.displayLarge?.color ??
              Colors.black,
          constraints: BoxConstraints(
            minWidth: AppWidgetSize.dimen_50,
            minHeight: AppWidgetSize.dimen_38,
          ),
          isSelected: [_selectedNseBseIndex == 0, _selectedNseBseIndex != 0],
          children: [
            Text(
              'NSE',
              textAlign: TextAlign.center,
              style: Theme.of(context).primaryTextTheme.titleLarge?.copyWith(
                    color: _selectedNseBseIndex == 0
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).primaryTextTheme.displayLarge?.color ??
                            Theme.of(context).textTheme.displayLarge?.color,
                    fontWeight: FontWeight.w500,
                  ) ??
                  Theme.of(context).textTheme.titleLarge!,
            ),
            Text(
              'BSE',
              textAlign: TextAlign.center,
              style: Theme.of(context).primaryTextTheme.titleLarge?.copyWith(
                    color: _selectedNseBseIndex == 1
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).primaryTextTheme.displayLarge?.color ??
                            Theme.of(context).textTheme.displayLarge?.color,
                    fontWeight: FontWeight.w500,
                  ) ??
                  Theme.of(context).textTheme.titleLarge!,
            ),
          ],
        ),
      ),
    );
  }

  String _formatChange(String chng) {
    // Remove commas and parse - handle both positive and negative
    String cleanChng = chng.replaceAll(',', '').trim();
    bool isNegative = cleanChng.startsWith('-');
    cleanChng = cleanChng.replaceAll('-', '').replaceAll('+', '');
    
    final chngValue = double.tryParse(cleanChng) ?? 0.0;
    
    // Format with comma for thousands
    String formattedChng = chngValue.toStringAsFixed(2);
    if (formattedChng.contains('.')) {
      final parts = formattedChng.split('.');
      final integerPart = parts[0];
      final decimalPart = parts[1];
      final formattedInteger = integerPart.replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );
      formattedChng = '$formattedInteger.$decimalPart';
    }
    
    if (isNegative || chngValue < 0) {
      return '₹-$formattedChng';
    } else if (chngValue > 0) {
      return '₹+$formattedChng';
    } else {
      return '₹0.00';
    }
  }

  Widget _buildIndexDropdown() {
    final indicesList = _selectedNseBseIndex == 0 ? _nseIndices : _bseIndices;
    final selectedIndexName = indicesList[_selectedIndexFilter];
    final isLight = Theme.of(context).brightness == Brightness.light;

    return OutlinedButton(
      onPressed: () {
        _showIndexList(indicesList, selectedIndexName);
      },
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.all(8)),
        backgroundColor: WidgetStatePropertyAll(
          isLight ? AppColors.primaryColorLight(true) : null,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        ),
        side: WidgetStatePropertyAll(
          BorderSide(
            color: isLight
                ? AppColors.primaryColorLight(true)
                : Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextWidget(
            selectedIndexName,
            Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.w,
                ) ??
                Theme.of(context).textTheme.bodyLarge!,
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.keyboard_arrow_down_outlined,
            color: Theme.of(context).textTheme.bodyLarge?.color,
            size: 16.w,
          ),
        ],
      ),
    );
  }

  void _showIndexList(List<String> indicesList, String selectedValue) {
    final initialIndex = indicesList.indexOf(selectedValue);

    InfoBottomSheet.showInfoBottomsheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 20.w,
              left: 30.w,
              right: 30.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextWidget(
                  'Index',
                  Theme.of(context).primaryTextTheme.titleSmall!,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: AppImages.closeIcon(
                    context,
                    color: Theme.of(context).primaryIconTheme.color,
                    isColor: true,
                    width: AppWidgetSize.dimen_22,
                    height: AppWidgetSize.dimen_22,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              itemCount: indicesList.length,
              separatorBuilder: (context, index) => Divider(
                thickness: 1,
                height: 1,
                color: Theme.of(context).dividerColor,
              ),
              itemBuilder: (context, index) {
                final isSelected = indicesList[index] == selectedValue;
                return ListTile(
                  horizontalTitleGap: 2,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                  title: CustomTextWidget(
                    indicesList[index],
                    Theme.of(context).primaryTextTheme.labelSmall?.copyWith(
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          fontSize: AppWidgetSize.fontSize16,
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : null,
                        ) ??
                        Theme.of(context).textTheme.bodyLarge!,
                  ),
                  trailing: isSelected
                      ? AppImages.greenTickIcon(
                          context,
                          width: AppWidgetSize.dimen_22,
                          height: AppWidgetSize.dimen_22,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedIndexFilter = index;
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        ],
      ),
      context,
      height: MediaQuery.of(context).size.height / 2.0,
      horizontalMargin: false,
    );
  }

  Widget _buildTableHeader() {
    return Row(
      children: [
        Expanded(
          child: _buildHeaderItem(_headerList[0]), // Scrip
        ),
        SizedBox(width: AppWidgetSize.dimen_8),
        Container(
          width: AppWidgetSize.dimen_60,
          alignment: Alignment.centerRight,
          child: _buildHeaderItem(_headerList[1]), // ADX
        ),
        SizedBox(width: AppWidgetSize.dimen_8),
        Container(
          width: AppWidgetSize.dimen_80,
          alignment: Alignment.centerRight,
          child: _buildHeaderItem(_headerList[2]), // 5 SMA
        ),
      ],
    );
  }

  Widget _buildHeaderItem(Map<String, String> header) {
    final isSorted = header['sort'] != null && header['sort'] != 'none';
    
    return GestureDetector(
      onTap: () {
        // Handle sort
        setState(() {
          // Toggle sort state
          if (header['sort'] == 'none') {
            header['sort'] = 'desc';
          } else if (header['sort'] == 'desc') {
            header['sort'] = 'asc';
          } else {
            header['sort'] = 'none';
          }
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextWidget(
            header['label'] ?? '',
            Theme.of(context).primaryTextTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isSorted ? AppColors.primaryColor(Theme.of(context).brightness == Brightness.light) : null,
                ) ?? Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isSorted ? AppColors.primaryColor(Theme.of(context).brightness == Brightness.light) : null,
                ) ?? TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isSorted ? AppColors.primaryColor(Theme.of(context).brightness == Brightness.light) : null,
                ),
            textAlign: TextAlign.end,
          ),
          SizedBox(width: AppWidgetSize.dimen_4),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppImages.sortUp(
                context,
                width: 12,
                height: 12,
                isColor: header['sort'] == 'desc',
                color: header['sort'] == 'desc'
                    ? AppColors.primaryColor(Theme.of(context).brightness == Brightness.light)
                    : null,
              ),
              AppImages.sortDown(
                context,
                width: 12,
                height: 12,
                isColor: header['sort'] == 'asc',
                color: header['sort'] == 'asc'
                    ? AppColors.primaryColor(Theme.of(context).brightness == Brightness.light)
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScannerRow(Map<String, dynamic> scannerData, int index) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final chngValue = double.tryParse(scannerData['chng']?.toString().replaceAll(',', '') ?? '0') ?? 0;
    final isPositive = chngValue >= 0;
    final color = isPositive
        ? AppColors.positiveColor(isLight)
        : AppColors.negativeColor;

    return Column(
      children: [
        Container(
          height: 80.w,
          padding: EdgeInsets.only(
            left: AppWidgetSize.dimen_16,
            right: AppWidgetSize.dimen_16,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Row(
            children: [
              // Symbol Column with LTP and Change % below
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: CustomTextWidget(
                            scannerData['baseSym'] ?? '--',
                            Theme.of(context).primaryTextTheme.labelLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.w,
                                ),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (scannerData['exc'] != null)
                          Padding(
                            padding: EdgeInsets.only(left: AppWidgetSize.dimen_8),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: AppWidgetSize.dimen_2,
                                horizontal: AppWidgetSize.dimen_4,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  AppWidgetSize.dimen_2,
                                ),
                                color: Theme.of(context).inputDecorationTheme.fillColor,
                              ),
                              child: CustomTextWidget(
                                scannerData['exc'] as String,
                                Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: AppWidgetSize.dimen_8,
                                    ) ?? TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: AppWidgetSize.dimen_8,
                                    ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: AppWidgetSize.dimen_8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomTextWidget(
                            _formatChange(scannerData['chng'] ?? '0'),
                            Theme.of(context).primaryTextTheme.labelSmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.w,
                                  color: color,
                                ),
                          ),
                          SizedBox(width: AppWidgetSize.dimen_4),
                          CustomTextWidget(
                            '(${isPositive ? '+' : ''}${scannerData['chngPer'] ?? '0'}%)',
                            Theme.of(context).primaryTextTheme.bodySmall!.copyWith(
                                  color: Theme.of(context)
                                          .inputDecorationTheme
                                          .labelStyle
                                          ?.color ??
                                      Theme.of(context).textTheme.bodySmall?.color,
                                  fontSize: 12.w,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: AppWidgetSize.dimen_8),
              // ADX Column
              Container(
                width: AppWidgetSize.dimen_60,
                alignment: Alignment.centerRight,
                child: CustomTextWidget(
                  scannerData['ADX25'] ?? '--',
                  Theme.of(context).primaryTextTheme.labelLarge!.copyWith(
                        fontSize: 16.w,
                      ),
                  textAlign: TextAlign.end,
                ),
              ),
              SizedBox(width: AppWidgetSize.dimen_8),
              // 5 SMA Column
              Container(
                width: AppWidgetSize.dimen_80,
                alignment: Alignment.centerRight,
                child: CustomTextWidget(
                  scannerData['SMA5'] ?? '--',
                  Theme.of(context).primaryTextTheme.labelLarge!.copyWith(
                        fontSize: 16.w,
                      ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1,
          height: 1,
          indent: AppWidgetSize.dimen_16,
          endIndent: AppWidgetSize.dimen_16,
        ),
      ],
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyHeaderDelegate({required this.child});

  @override
  double get minExtent {
    // Calculate based on: top padding (4.w) + toggle height (38.w) + bottom padding (8.w) = 50.w
    // But add a bit more to account for any spacing
    return 50.w;
  }

  @override
  double get maxExtent => minExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: overlapsContent ? 4.0 : 0.0,
      child: SizedBox(
        height: minExtent,
        child: child,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.minExtent != minExtent;
  }
}
