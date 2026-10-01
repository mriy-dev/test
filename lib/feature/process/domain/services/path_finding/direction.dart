import 'package:webspark/feature/home/domain/models/point_model.dart';

enum Direction {
  up(0, -1),
  down(0, 1),
  left(-1, 0),
  right(1, 0),
  upLeft(-1, -1),
  upRight(1, -1),
  downLeft(-1, 1),
  downRight(1, 1);

  const Direction(this.dx, this.dy);

  final int dx;
  final int dy;

  PointModel moveFrom(PointModel p) => PointModel(x: p.x + dx, y: p.y + dy);
}
