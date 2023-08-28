// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChartDataAdapter extends TypeAdapter<ChartData> {
  @override
  final int typeId = 2;

  @override
  ChartData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChartData(
      listData: (fields[0] as List).cast<CartModel>(),
      orderDate: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ChartData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.listData)
      ..writeByte(1)
      ..write(obj.orderDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChartDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
