import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../blocs/establish/establish_bloc.dart';
import '../../utils/constants/color_app.dart';
import '../../utils/constants/text_style.dart';

class HistoryDetailsViewScreen extends StatefulWidget {
  const HistoryDetailsViewScreen({
    super.key,
    required this.tid,
    required this.tdId,
  });

  final String tid;
  final String tdId;

  @override
  State<HistoryDetailsViewScreen> createState() => _HistoryDetailsViewScreenState();
}

class _HistoryDetailsViewScreenState extends State<HistoryDetailsViewScreen> {
  // Default spacing value
  final double _defaultSpacing = 12.0;

  @override
  void initState() {
    super.initState();
    // Fetch vehicle details
    context.read<EstablishBloc>().add(GetCarDetailEvent(widget.tdId));
    // Fetch vehicle images
    context.read<EstablishBloc>().add(GetCarDetailImageEvent(widget.tid, widget.tdId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Theme.of(context).colorScheme.surface,
            size: 22.h,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'การเข้าชั่งน้ำหนัก',
          textAlign: TextAlign.center,
          style: AppTextStyle.title18bold(color: Theme.of(context).colorScheme.surface),
        ),
      ),
      body: BlocBuilder<EstablishBloc, EstablishState>(
        builder: (context, state) {
          // Show loading indicator
          if (state.carDetailStatus == CarInUnitDetailStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Show error message
          if (state.carDetailStatus == CarInUnitDetailStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: Theme.of(context).colorScheme.error),
                  SizedBox(height: 16),
                  Text(
                    'Error loading data\n${state.carDetailError}',
                    style: AppTextStyle.title16normal(color: Theme.of(context).colorScheme.error),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Retry loading data
                      context.read<EstablishBloc>().add(GetCarDetailEvent(widget.tdId));
                      context.read<EstablishBloc>().add(GetCarDetailImageEvent(widget.tid, widget.tdId));
                    },
                    child: Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          // Show content when data is loaded
          return SingleChildScrollView(
            padding: EdgeInsets.all(_defaultSpacing.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location header section
                _buildSectionHeader(context, Icons.location_on, 'ที่ตั้งหน่วย'),
                SizedBox(height: _defaultSpacing.h),

                // Vehicle information
                if (state.carDetail != null) ...[
                  // License plate information
                  textViewWidget('ทะเบียนรถ', state.carDetail?.lpHeadNo ?? '-'),
                  textViewWidget('จังหวัด', state.carDetail?.lpHeadProvinceName ?? '-'),
                  textViewWidget('ทะเบียนรถหางลาก', state.carDetail?.lpTailNo ?? '-'),
                  textViewWidget('จังหวัดหางลาก', state.carDetail?.lpTailProvinceName ?? '-'),
                  textViewWidget('ประเภทรถบรรทุก', state.carDetail?.vehicleClassDesc ?? '-'),

                  // Axle count and legal weight
                  Row(
                    children: [
                      Expanded(
                        child: textViewWidget('จำนวนเพลา', state.carDetail?.vehicleClassLegalDriveShaftRef ?? '-'),
                      ),
                      SizedBox(width: _defaultSpacing.w),
                      Expanded(
                        child: textViewWidget('น้ำหนักตามกฎหมาย', StringHleper.convertStringToKilo(state.carDetail?.legalWeight ?? '0')),
                      ),
                    ],
                  ),

                  // Cargo information
                  textViewWidget('บรรทุก', state.carDetail?.masterialName ?? '-'),

                  // Axle weights (grouped by axle count)
                  _buildAxleWeightsSection(state.carDetail),

                  // Weight status
                  Row(
                    children: [
                      Expanded(
                        child: textViewWidget(
                          'น้ำหนักรวม',
                          StringHleper.numberAddComma(WeightUnit.tonToKilo(StringHleper.stringToDouble(state.carDetail?.grossWeight ?? '0')).toStringAsFixed(0)),
                        ),
                      ),
                      SizedBox(width: _defaultSpacing.w),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'สถานะ',
                                style: AppTextStyle.title16bold(),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '',
                                    style: AppTextStyle.title18normal(color: Theme.of(context).colorScheme.error),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 40.h,
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: _defaultSpacing.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.r),
                                border: Border.all(color: Theme.of(context).colorScheme.onTertiary),
                                color: Theme.of(context).colorScheme.onTertiaryContainer,
                              ),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                state.carDetail?.isOverWeightDesc ?? 'Unknown status',
                                textAlign: TextAlign.center,
                                style: AppTextStyle.title16bold(
                                  color: _getStatusColor(state.carDetail?.isOverWeight),
                                ),
                              ),
                            ),
                            SizedBox(height: _defaultSpacing.w),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],

                SizedBox(height: _defaultSpacing.w),

                // Photos section
                _buildSectionHeader(context, Icons.photo_size_select_actual_outlined, 'รูปการจัดตั้งหน่วยชั่ง'),
                SizedBox(height: _defaultSpacing.w),

                // Image gallery
                Wrap(
                  spacing: 26.w,
                  runSpacing: _defaultSpacing.w,
                  children: [
                    _buildImageTile('ด้านหน้า', state.carDatailImage?.imagePath1),
                    _buildImageTile('ด้านหลัง', state.carDatailImage?.imagePath2),
                    _buildImageTile('ด้านซ้าย', state.carDatailImage?.imagePath3),
                    _buildImageTile('ด้านขวา', state.carDatailImage?.imagePath4),
                    _buildImageTile('สลิปน้ำหนัก', state.carDatailImage?.imagePath5),
                    _buildImageTile('ใบขับขี่', state.carDatailImage?.imagePath6),
                  ],
                ),
                SizedBox(height: _defaultSpacing.w),
              ],
            ),
          );
        },
      ),
    );
  }

  // Build section header with icon and title
  Widget _buildSectionHeader(BuildContext context, IconData icon, String title) {
    return Row(
      children: [
        Container(
            height: 32.h,
            width: 32.h,
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(90.r)),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.surface,
              size: 20.h,
            )),
        SizedBox(width: _defaultSpacing.w),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyle.title18bold(color: Theme.of(context).colorScheme.primary),
        ),
      ],
    );
  }

  // Build axle weights section based on axle count
  Widget _buildAxleWeightsSection(carDetail) {
    if (carDetail == null) return const SizedBox.shrink();

    List<Widget> axleRows = [];
    final int axleCount = int.tryParse(carDetail.vehicleClassLegalDriveShaftRef ?? '0') ?? 0;

    // Create rows of axles in pairs
    for (int i = 0; i < axleCount; i += 2) {
      if (i + 1 < axleCount) {
        // Two axles in one row
        axleRows.add(
          Row(
            children: [
              Expanded(
                child: textViewWidget(
                  'น้ำหนักเพลาที่ ${i + 1} (กิโลกรัม)',
                  _getAxleWeight(carDetail, i + 1),
                ),
              ),
              SizedBox(width: _defaultSpacing.w),
              Expanded(
                child: textViewWidget(
                  'น้ำหนักเพลาที่ ${i + 2} (กิโลกรัม)',
                  _getAxleWeight(carDetail, i + 2),
                ),
              ),
            ],
          ),
        );
      } else {
        // Single axle in the last row (for odd number of axles)
        axleRows.add(
          textViewWidget(
            'น้ำหนักเพลาที่ ${i + 1} (กิโลกรัม)',
            _getAxleWeight(carDetail, i + 1),
          ),
        );
      }
    }

    return Column(children: axleRows);
  }

  // Get the weight of the specified axle
  String _getAxleWeight(dynamic carDetail, int axleNumber) {
    if (carDetail == null) return '-';

    String? value;
    switch (axleNumber) {
      case 1:
        value = carDetail.ds1;
        break;
      case 2:
        value = carDetail.ds2;
        break;
      case 3:
        value = carDetail.ds3;
        break;
      case 4:
        value = carDetail.ds4;
        break;
      case 5:
        value = carDetail.ds5;
        break;
      case 6:
        value = carDetail.ds6;
        break;
      case 7:
        value = carDetail.ds7;
        break;
      default:
        value = null;
    }

    if (value == null || value.isEmpty) {
      return '-';
    }

    // Convert from tons to kilograms and format
    double weightInTons = double.tryParse(value) ?? 0.0;
    double weightInKilos = WeightUnit.tonToKilo(weightInTons);
    return StringHleper.numberAddComma(weightInKilos.toStringAsFixed(0));
  }

  // Get color for weight status
  Color _getStatusColor(String? isOverweight) {
    if (isOverweight == 'Y') {
      return ColorApps.colorRed;
    } else if (isOverweight == 'N') {
      return ColorApps.colorGreen;
    } else {
      return Theme.of(context).colorScheme.tertiary;
    }
  }

  // Build image tile with label and image
  Widget _buildImageTile(String label, String? imageUrl) {
    final bool hasImage = imageUrl != null && imageUrl.isNotEmpty;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 150,
        maxWidth: MediaQuery.of(context).size.width / 2 - 32,
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 10),
              Text(
                label,
                textAlign: TextAlign.center,
                style: AppTextStyle.title16bold(),
              ),
            ],
          ),
          hasImage
              ? GestureDetector(
                  onTap: () => _showImagePreview(context, imageUrl),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    height: 150.w,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      border: Border.all(color: ColorApps.grayBorder),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1) : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(Icons.broken_image, size: 40),
                          );
                        },
                      ),
                    ),
                  ),
                )
              : Container(
                  margin: EdgeInsets.all(8),
                  height: 150.w,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(color: ColorApps.grayBorder),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      'No image',
                      style: AppTextStyle.title14normal(color: Colors.grey),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  // Show fullscreen image preview
  void _showImagePreview(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
          content: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1) : null,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  // Widget for displaying label and value
  Widget textViewWidget(String title, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: AppTextStyle.title16bold(),
            children: <TextSpan>[
              TextSpan(
                text: '',
                style: AppTextStyle.title18normal(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ),
        ),
        Container(
          height: 35.h,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: _defaultSpacing.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: Theme.of(context).colorScheme.onTertiary),
            color: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: AppTextStyle.title16normal(),
          ),
        ),
        SizedBox(height: _defaultSpacing.w),
      ],
    );
  }
}

// Helper class for string formatting and unit conversion (use if not already in project)
class StringHleper {
  // Add comma separators to numbers
  static String numberAddComma(String number) {
    if (number.isEmpty) return '0';

    try {
      // Handle decimal numbers
      List<String> parts = number.split('.');
      String integerPart = parts[0];

      // Handle negative numbers
      bool isNegative = integerPart.startsWith('-');
      if (isNegative) {
        integerPart = integerPart.substring(1);
      }

      // Add commas
      final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
      String result = integerPart.replaceAllMapped(reg, (Match match) => '${match[1]},');

      // Add back decimal part if exists
      if (parts.length > 1) {
        result = '$result.${parts[1]}';
      }

      // Add back negative sign if needed
      if (isNegative) {
        result = '-$result';
      }

      return result;
    } catch (e) {
      return number;
    }
  }

  // Remove commas from formatted number string
  static String numberStringCutComma(String number) {
    if (number.isEmpty) return '0';
    return number.replaceAll(',', '');
  }

  // Convert string to double
  static double stringToDouble(String? value) {
    if (value == null || value.isEmpty) return 0.0;

    String processedValue = value.replaceAll(',', '');
    return double.tryParse(processedValue) ?? 0.0;
  }

  // Format double to comma-separated string
  static String doubleToStringComma(String value) {
    if (value.isEmpty) return '0';

    try {
      double number = double.parse(value);
      return numberAddComma(number.toStringAsFixed(0));
    } catch (e) {
      return value;
    }
  }

  // Convert weight to kilograms format
  static String convertStringToKilo(String? weightValue) {
    if (weightValue == null || weightValue.isEmpty) return '0';

    try {
      double weight = stringToDouble(weightValue);
      return numberAddComma(weight.toStringAsFixed(0));
    } catch (e) {
      return weightValue;
    }
  }
}

// Weight unit conversion helper (use if not already in project)
class WeightUnit {
  // Convert tons to kilograms
  static double tonToKilo(double tonValue) {
    return tonValue * 1000;
  }

  // Convert kilograms to tons
  static double kiloToTon(double kiloValue) {
    return kiloValue / 1000;
  }
}
