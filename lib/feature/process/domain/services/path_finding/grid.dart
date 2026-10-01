import 'package:webspark/feature/home/domain/models/point_model.dart';

class Grid {
  const Grid(this.rows);

  static const blocked = 'X';

  final List<String> rows;

  int get freeCellCount => rows.join().replaceAll(blocked, '').length;

  bool contains(PointModel p) =>
      p.y >= 0 && p.y < rows.length && p.x >= 0 && p.x < rows[p.y].length;

  bool isBlocked(PointModel p) => contains(p) && rows[p.y][p.x] == blocked;

  bool isFree(PointModel p) => contains(p) && !isBlocked(p);
}
