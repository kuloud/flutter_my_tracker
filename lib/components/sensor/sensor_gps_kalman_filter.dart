// import 'package:flutter_my_tracker/components/sensor/ext/matrix_ext.dart';
// import 'package:flutter_my_tracker/components/sensor/kalman_filter.dart';
// import 'package:matrices/matrices.dart';

// class GPSAccKalmanFilter {
//   late double m_timeStampMsPredict;
//   late double m_timeStampMsUpdate;
//   late int m_predictCount;
//   late KalmanFilter m_kf;
//   late double m_accSigma;
//   late bool m_useGpsSpeed;
//   double mVelFactor = 1.0;
//   double mPosFactor = 1.0;

//   GPSAccKalmanFilter(
//       bool useGpsSpeed,
//       double x,
//       double y,
//       double xVel,
//       double yVel,
//       double accDev,
//       double posDev,
//       double timeStampMs,
//       double velFactor,
//       double posFactor) {
//     int mesDim = useGpsSpeed ? 4 : 2;
//     m_useGpsSpeed = useGpsSpeed;
//     m_kf = KalmanFilter(4, mesDim, 2);
//     m_timeStampMsPredict = m_timeStampMsUpdate = timeStampMs;
//     m_accSigma = accDev;
//     m_predictCount = 0;
//     m_kf.Xk_k.setRow([x, y, xVel, yVel], 0);
//     m_kf.H.setIdentityDiag();
//     m_kf.Pk_k = SquareMatrix.diagonalFromNumber(posDev, m_kf.Pk_k.rowCount);
//     mVelFactor = velFactor;
//     mPosFactor = posFactor;
//   }

//   void rebuildF(double dtPredict) {
//     List<double> f = [
//       1.0,
//       0.0,
//       dtPredict,
//       0.0,
//       0.0,
//       1.0,
//       0.0,
//       dtPredict,
//       0.0,
//       0.0,
//       1.0,
//       0.0,
//       0.0,
//       0.0,
//       0.0,
//       1.0
//     ];
//     m_kf.F = Matrix.fromFlattenedList(f, 4, 4);
//   }

//   void rebuildU(double xAcc, double yAcc) {
//     m_kf.Uk.setRow([xAcc, yAcc], 0);
//   }

//   void rebuildB(double dtPredict) {
//     double dt2 = 0.5 * dtPredict * dtPredict;
//     List<double> b = [dt2, 0.0, 0.0, dt2, dtPredict, 0.0, 0.0, dtPredict];
//     m_kf.B = Matrix.fromFlattenedList(b, 4, 2);
//   }

//   void rebuildR(double posSigma, double velSigma) {
//     posSigma *= mPosFactor;
//     velSigma *= mVelFactor;
//     if (m_useGpsSpeed) {
//       List<double> R = [
//         posSigma,
//         0.0,
//         0.0,
//         0.0,
//         0.0,
//         posSigma,
//         0.0,
//         0.0,
//         0.0,
//         0.0,
//         velSigma,
//         0.0,
//         0.0,
//         0.0,
//         0.0,
//         velSigma
//       ];
//       m_kf.R = Matrix.fromFlattenedList(R, 4, 4);
//     } else {
//       m_kf.R = SquareMatrix.diagonalFromNumber(posSigma, 4);
//     }
//   }

//   void rebuildQ(double dtUpdate, double accDev) {
//     double velDev = accDev * m_predictCount;
//     double posDev = velDev * m_predictCount / 2;
//     double covDev = velDev * posDev;
//     double posSig = posDev * posDev;
//     double velSig = velDev * velDev;
//     List<double> Q = [
//       posSig,
//       0.0,
//       covDev,
//       0.0,
//       0.0,
//       posSig,
//       0.0,
//       covDev,
//       covDev,
//       0.0,
//       velSig,
//       0.0,
//       0.0,
//       covDev,
//       0.0,
//       velSig
//     ];
//     m_kf.Q = Matrix.fromFlattenedList(Q, 4, 4);
//   }

//   void predict(double timeNowMs, double xAcc, double yAcc) {
//     double dtPredict = (timeNowMs - m_timeStampMsPredict) / 1000.0;
//     double dtUpdate = (timeNowMs - m_timeStampMsUpdate) / 1000.0;
//     rebuildF(dtPredict);
//     rebuildB(dtPredict);
//     rebuildU(xAcc, yAcc);
//     ++m_predictCount;
//     rebuildQ(dtUpdate, m_accSigma);
//     m_timeStampMsPredict = timeNowMs;
//     m_kf.predict();
//     m_kf.Xk_k = Matrix.fromList(m_kf.Xk_km1.matrix);
//   }

//   void update(double timeStamp, double x, double y, double xVel, double yVel,
//       double posDev, double velErr) {
//     m_predictCount = 0;
//     m_timeStampMsUpdate = timeStamp;
//     rebuildR(posDev, velErr);
//     if (m_useGpsSpeed) {
//       m_kf.Zk.setRow([x, y, xVel, yVel], 0);
//     } else {
//       m_kf.Zk.setRow([x, y], 0);
//     }
//     m_kf.update();
//   }

//   double getCurrentX() {
//     return m_kf.Xk_k[0][0];
//   }

//   double getCurrentY() {
//     return m_kf.Xk_k[1][0];
//   }

//   double getCurrentXVel() {
//     return m_kf.Xk_k[2][0];
//   }

//   double getCurrentYVel() {
//     return m_kf.Xk_k[3][0];
//   }
// }
