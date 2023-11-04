import 'package:matrices/matrices.dart';

extension MatrixExt on Matrix {
  void setIdentityDiag() {
    for (var i = 0; i < rowCount; i++) {
      for (var j = 0; j < columnCount; j++) {
        this[i][j] = 0;
      }
      this[i][i] = 1;
    }
  }

  bool matrixDestructiveInvert(Matrix mtxout) {
    int r, ri;
    double scalar;

    for (r = 0; r < rowCount; ++r) {
      if (this[r][r] == 0.0) {
        // 交换行以确保对角线上的元素非零
        for (ri = r; ri < rowCount; ++ri) {
          if (this[ri][ri] != 0.0) break;
        }
        if (ri == rowCount) return false; // 无法获取逆矩阵

        swapRows(r, ri);
        mtxout.swapRows(r, ri);
      }

      scalar = 1.0 / this[r][r];
      scaleRow(r, scalar);
      mtxout.scaleRow(r, scalar);

      for (ri = 0; ri < r; ++ri) {
        scalar = -this[ri][r];
        shearRow(ri, r, scalar);
        mtxout.shearRow(ri, r, scalar);
      }

      for (ri = r + 1; ri < rowCount; ++ri) {
        scalar = -this[ri][r];
        shearRow(ri, r, scalar);
        mtxout.shearRow(ri, r, scalar);
      }
    }

    return true;
  }

  void swapRows(int r1, int r2) {
    assert(r1 != r2);
    List<double> tmp = this[r1];
    this[r1] = this[r2];
    this[r2] = tmp;
  }

  void scaleRow(int r, double scalar) {
    for (int c = 0; c < this[r].length; ++c) {
      this[r][c] *= scalar;
    }
  }

  void shearRow(int r1, int r2, double scalar) {
    for (int c = 0; c < this[r1].length; ++c) {
      this[r1][c] += this[r2][c] * scalar;
    }
  }
}
