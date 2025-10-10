class BarChartVehicleWeight {
  List<String>? labels;
  List<int>? vechicleWeight;
  List<int>? vechicleWeightOver;

  BarChartVehicleWeight({this.labels, this.vechicleWeight, this.vechicleWeightOver});

  BarChartVehicleWeight.fromJson(Map<String, dynamic> json) {
    labels = json['labels,'].cast<String>();
    vechicleWeight = json['vechicle_weight'].cast<int>();
    vechicleWeightOver = json['vechicle_weight_over'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['labels,'] = this.labels;
    data['vechicle_weight'] = this.vechicleWeight;
    data['vechicle_weight_over'] = this.vechicleWeightOver;
    return data;
  }
}
