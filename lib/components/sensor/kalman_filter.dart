import 'package:flutter_my_tracker/components/sensor/ext/matrix_ext.dart';
import 'package:matrices/matrices.dart';

class KalmanFilter {
  late Matrix F; // 4*4
  late Matrix H; // n*4
  late Matrix B; // n*2
  late Matrix Q; // 4*4
  late Matrix R; // n*n
  late Matrix Uk; // 2*1
  late Matrix Zk; // n*1
  late Matrix Xk_km1; // 4*1
  late Matrix Pk_km1; // 4*4
  late Matrix Yk; // n*1
  late Matrix Sk; // n*n
  late Matrix SkInv; // n*n
  late Matrix K; // 4*n
  late Matrix Xk_k; // 4*1
  late Matrix Pk_k; // 4*4
  late Matrix Yk_k; // n*1
  late Matrix auxBxU; // 4*1
  late Matrix auxSDxSD; // 4*4
  late Matrix auxSDxMD; // 4*n

  KalmanFilter(int stateDimension, int measureDimension, int controlDimension) {
    F = Matrix.zero(stateDimension, stateDimension);
    H = Matrix.zero(measureDimension, stateDimension);
    Q = Matrix.zero(stateDimension, stateDimension);
    R = Matrix.zero(measureDimension, measureDimension);
    B = Matrix.zero(stateDimension, controlDimension);
    Uk = Matrix.zero(controlDimension, 1);
    Zk = Matrix.zero(measureDimension, 1);
    Xk_km1 = Matrix.zero(stateDimension, 1);
    Pk_km1 = Matrix.zero(stateDimension, stateDimension);
    Yk = Matrix.zero(measureDimension, 1);
    Sk = Matrix.zero(measureDimension, measureDimension);
    SkInv = Matrix.zero(measureDimension, measureDimension);
    K = Matrix.zero(stateDimension, measureDimension);
    Xk_k = Matrix.zero(stateDimension, 1);
    Pk_k = Matrix.zero(stateDimension, stateDimension);
    Yk_k = Matrix.zero(measureDimension, 1);
    auxBxU = Matrix.zero(stateDimension, 1);
    auxSDxSD = Matrix.zero(stateDimension, stateDimension);
    auxSDxMD = Matrix.zero(stateDimension, measureDimension);
  }

  void predict() {
    Xk_km1 = F * Xk_k;
    auxBxU = B * Uk;
    Xk_km1 = Xk_km1 + auxBxU;

    auxSDxSD = F * Pk_k;
    Pk_km1 = auxSDxSD * F.transpose;
    Pk_km1 = Pk_km1 + Q;
  }

  void update() {
    Yk = H * Xk_km1;
    Yk = Zk - Yk;
    auxSDxMD = Pk_km1 * H.transpose;
    Sk = H * auxSDxMD;
    Sk = R + Sk;

    final mtxout = SquareMatrix.identity(Sk.rowCount);
    //Kk = Pk|k-1*Hk(t)*Sk(inv)
    if (!(Sk.matrixDestructiveInvert(mtxout))) return; //matrix hasn't inversion

    K = auxSDxMD * SkInv;
    Xk_k = K * Yk;
    Xk_k += Xk_km1;

    auxSDxSD = K * H;
    auxSDxSD = SquareMatrix.identity(auxSDxSD.rowCount) - auxSDxSD;
    Pk_k = auxSDxSD * Pk_km1;
  }
}
