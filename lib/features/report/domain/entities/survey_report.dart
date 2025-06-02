class SurveyReport {
  final String id;
  final int reportId;
  final String installationLocation;
  final String roofFrameType;
  final String needsReinforcement;
  final String installationDirection;
  final String obstructedByShade;
  final String coldWaterLine;
  final String hotWaterLine;
  final String waterLineProvider;
  final String estimatedWaterLineInstallation;
  final String electricalCableLine;
  final String cableLineProvider;
  final String estimatedCableLineInstallation;
  final String voltage;
  final String amperage;
  final String hertz;
  final String watt;
  final String coldWaterSource;
  final String waterFromReservoir;
  final String boosterPump;
  final String pressureBar;
  final String? poolVolume;
  final String? poolLength;
  final String? poolWidth;
  final String? poolHeight;
  final String? initialTemperature;
  final String? targetTemperature;
  final DateTime visitDate;
  final String? note;
  final String imageUrl;
  final String surveyorSignatureUrl;
  final String customerSignatureUrl;

  SurveyReport({
    required this.id,
    required this.reportId,
    required this.installationLocation,
    required this.roofFrameType,
    required this.needsReinforcement,
    required this.installationDirection,
    required this.obstructedByShade,
    required this.coldWaterLine,
    required this.hotWaterLine,
    required this.waterLineProvider,
    required this.estimatedWaterLineInstallation,
    required this.electricalCableLine,
    required this.cableLineProvider,
    required this.estimatedCableLineInstallation,
    required this.voltage,
    required this.amperage,
    required this.hertz,
    required this.watt,
    required this.coldWaterSource,
    required this.waterFromReservoir,
    required this.boosterPump,
    required this.pressureBar,
    this.poolVolume,
    this.poolLength,
    this.poolWidth,
    this.poolHeight,
    this.initialTemperature,
    this.targetTemperature,
    required this.visitDate,
    this.note,
    required this.imageUrl,
    required this.surveyorSignatureUrl,
    required this.customerSignatureUrl,
  });
}
