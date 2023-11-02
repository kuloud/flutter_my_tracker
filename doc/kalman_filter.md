
Extended Kalman Filter (EKF) 是基于速度和GPS经纬度的滤波拟合算法。

## 定义：
1. 速度单位 m/s，速度方差为 `speed_variance`
1. 记录GPS轨迹，定位点方差为 `gps_variance`

## EKF原理：
初始化矩阵P、H、Q和R:

P矩阵表示状态估计的不确定性或协方差。应该初始化一个较大的值，以反映初始的不确定性。一种常见的方法是将P设置为沿对角线方向具有较大值的对角矩阵。具体的值取决于被建模的系统，并且应该基于系统的先验知识来选择。

H矩阵是测量模型或观测矩阵。它将状态估计映射到预测的测量。它取决于正在建模的特定系统，并应相应地定义。

Q矩阵是过程噪声协方差矩阵。它表示系统动力学中的不确定性或噪声。具体的值取决于被建模的系统，并且应该基于系统的先验知识来选择。

其中R矩阵为测量噪声协方差矩阵。它表示传感器测量中的不确定度或噪声。具体值取决于所使用的传感器，并应根据传感器的校准来选择。

状态转移矩阵F将前一个时间步长的状态与当前时间步长的状态以线性形式联系起来。具体来说，它定义了时刻k和时刻k-1的状态之间的关系。

一旦这些矩阵初始化，EKF就可以开始估计系统的状态，通过迭代预测状态，将其与测量值进行比较，并使用卡尔曼增益更新状态估计。

状态转移矩阵F将前一个时间步长的状态与当前时间步长的状态以线性形式联系起来。具体来说，它定义了时刻k和时刻k-1的状态之间的关系。矩阵F可以根据系统的动态模型计算，该模型描述了被卡尔曼滤波器建模的系统的行为。

状态协方差矩阵P描述了状态估计中的不确定性。它表示状态向量元素之间的协方差，并根据预测状态和测量数据在每个时间步更新。矩阵P在滤波器的开始处初始化，并对状态不确定性进行初始估计。

状态转移矩阵F描述被建模系统的线性动力学，状态协方差矩阵P表示估计状态的不确定性。在EKF的预测步骤中使用这两个矩阵来更新预测状态和相关的不确定性估计。

## 使用方式：
1. 定义`状态向量` 和 `测量向量`:

    1. 状态向量
        <math xmlns="http://www.w3.org/1998/Math/MathML">
        <mi>x</mi>
        </math>
    包含水平方向的位置、速度和加速度，定义为:

        <math xmlns="http://www.w3.org/1998/Math/MathML">
            <mi>x</mi>
            <mo>=</mo>
            <mo stretchy="false">[</mo>
            <mi>p</mi>
            <mi>o</mi>
            <mi>s</mi>
            <mi>i</mi>
            <mi>t</mi>
            <mi>i</mi>
            <mi>o</mi>
            <msub>
                <mi>n</mi>
                <mi>x</mi>
            </msub>
            <mo>,</mo>
            <mi>p</mi>
            <mi>o</mi>
            <mi>s</mi>
            <mi>i</mi>
            <mi>t</mi>
            <mi>i</mi>
            <mi>o</mi>
            <msub>
                <mi>n</mi>
                <mi>y</mi>
            </msub>
            <mo>,</mo>
            <mi>v</mi>
            <mi>e</mi>
            <mi>l</mi>
            <mi>o</mi>
            <mi>c</mi>
            <mi>i</mi>
            <mi>t</mi>
            <msub>
                <mi>y</mi>
                <mi>x</mi>
            </msub>
            <mo>,</mo>
            <mi>v</mi>
            <mi>e</mi>
            <mi>l</mi>
            <mi>o</mi>
            <mi>c</mi>
            <mi>i</mi>
            <mi>t</mi>
            <msub>
                <mi>y</mi>
                <mi>y</mi>
            </msub>
            <mo>,</mo>
            <mi>a</mi>
            <mi>c</mi>
            <mi>c</mi>
            <mi>e</mi>
            <mi>l</mi>
            <mi>e</mi>
            <mi>r</mi>
            <mi>a</mi>
            <mi>t</mi>
            <mi>i</mi>
            <mi>o</mi>
            <msub>
                <mi>n</mi>
                <mi>x</mi>
            </msub>
            <mo>,</mo>
            <mi>a</mi>
            <mi>c</mi>
            <mi>c</mi>
            <mi>e</mi>
            <mi>l</mi>
            <mi>e</mi>
            <mi>r</mi>
            <mi>a</mi>
            <mi>t</mi>
            <mi>i</mi>
            <mi>o</mi>
            <msub>
                <mi>n</mi>
                <mi>y</mi>
            </msub>
            <mo stretchy="false">]</mo>
        </math>
        
    1. 测量向量
        <math xmlns="http://www.w3.org/1998/Math/MathML">
        <mi>z</mi>
        </math>
        包含GPS位置和速度，定义为:

        <math xmlns="http://www.w3.org/1998/Math/MathML">
        <mi>z</mi>
        <mo>=</mo>
        <mo stretchy="false">[</mo>
        <mi>p</mi>
        <mi>o</mi>
        <mi>s</mi>
        <mi>i</mi>
        <mi>t</mi>
        <mi>i</mi>
        <mi>o</mi>
        <msub>
            <mi>n</mi>
            <mi>x</mi>
        </msub>
        <mo>,</mo>
        <mi>p</mi>
        <mi>o</mi>
        <mi>s</mi>
        <mi>i</mi>
        <mi>t</mi>
        <mi>i</mi>
        <mi>o</mi>
        <msub>
            <mi>n</mi>
            <mi>y</mi>
        </msub>
        <mo>,</mo>
        <mi>s</mi>
        <mi>p</mi>
        <mi>e</mi>
        <mi>e</mi>
        <mi>d</mi>
        <mo stretchy="false">]</mo>
        </math>

    1. 定义状态转换函数:

        状态转换函数
        <math xmlns="http://www.w3.org/1998/Math/MathML">
        <mi>f</mi>
        <mi>(</mi>
        <mi>x</mi>
        <mi>)</mi>
        </math>
        , 根据当前状态和经过的时间预测汽车在下一个时间步的状态。在这种情况下，可以使用当前和以前的GPS测量值之间的时间差来估计经过的时间。假设匀速模型，状态转移函数可定义为:

        <math xmlns="http://www.w3.org/1998/Math/MathML">
        <mi>f</mi>
        <mo stretchy="false">(</mo>
        <mi>x</mi>
        <mo stretchy="false">)</mo>
        <mo>=</mo>
        <mo stretchy="false">[</mo>
        <mi>p</mi>
        <mi>o</mi>
        <mi>s</mi>
        <mi>i</mi>
        <mi>t</mi>
        <mi>i</mi>
        <mi>o</mi>
        <msub>
            <mi>n</mi>
            <mi>x</mi>
        </msub>
        <mo>+</mo>
        <mi>v</mi>
        <mi>e</mi>
        <mi>l</mi>
        <mi>o</mi>
        <mi>c</mi>
        <mi>i</mi>
        <mi>t</mi>
        <msub>
            <mi>y</mi>
            <mi>x</mi>
        </msub>
        <mo>&#x2217;</mo>
        <mi>d</mi>
        <mi>t</mi>
        <mo>,</mo>
        <mi>p</mi>
        <mi>o</mi>
        <mi>s</mi>
        <mi>i</mi>
        <mi>t</mi>
        <mi>i</mi>
        <mi>o</mi>
        <msub>
            <mi>n</mi>
            <mi>y</mi>
        </msub>
        <mo>+</mo>
        <mi>v</mi>
        <mi>e</mi>
        <mi>l</mi>
        <mi>o</mi>
        <mi>c</mi>
        <mi>i</mi>
        <mi>t</mi>
        <msub>
            <mi>y</mi>
            <mi>y</mi>
        </msub>
        <mo>&#x2217;</mo>
        <mi>d</mi>
        <mi>t</mi>
        <mo>,</mo>
        <mi>v</mi>
        <mi>e</mi>
        <mi>l</mi>
        <mi>o</mi>
        <mi>c</mi>
        <mi>i</mi>
        <mi>t</mi>
        <msub>
            <mi>y</mi>
            <mi>x</mi>
        </msub>
        <mo>,</mo>
        <mi>v</mi>
        <mi>e</mi>
        <mi>l</mi>
        <mi>o</mi>
        <mi>c</mi>
        <mi>i</mi>
        <mi>t</mi>
        <msub>
            <mi>y</mi>
            <mi>y</mi>
        </msub>
        <mo>,</mo>
        <mi>a</mi>
        <mi>c</mi>
        <mi>c</mi>
        <mi>e</mi>
        <mi>l</mi>
        <mi>e</mi>
        <mi>r</mi>
        <mi>a</mi>
        <mi>t</mi>
        <mi>i</mi>
        <mi>o</mi>
        <msub>
            <mi>n</mi>
            <mi>x</mi>
        </msub>
        <mo>,</mo>
        <mi>a</mi>
        <mi>c</mi>
        <mi>c</mi>
        <mi>e</mi>
        <mi>l</mi>
        <mi>e</mi>
        <mi>r</mi>
        <mi>a</mi>
        <mi>t</mi>
        <mi>i</mi>
        <mi>o</mi>
        <msub>
            <mi>n</mi>
            <mi>y</mi>
        </msub>
        <mo stretchy="false">]</mo>
        </math>
        
        
        _<math xmlns="http://www.w3.org/1998/Math/MathML">
        <mi>d</mi>
        <mi>t</mi>
        </math>是当前和以前的GPS测量之间的时间差_
        
    1. 定义测量函数:
        
        测量函数
        <math xmlns="http://www.w3.org/1998/Math/MathML">
        <mi>h</mi>
        <mi>(</mi>
        <mi>x</mi>
        <mi>)</mi>
        </math>
        在给定当前状态的情况下预测预期的GPS位置和速度。假设速度与车速成线性关系，则测量函数可定义为:

        <math xmlns="http://www.w3.org/1998/Math/MathML">
        <mi>h</mi>
        <mo stretchy="false">(</mo>
        <mi>x</mi>
        <mo stretchy="false">)</mo>
        <mo>=</mo>
        <mo stretchy="false">[</mo>
        <mi>p</mi>
        <mi>o</mi>
        <mi>s</mi>
        <mi>i</mi>
        <mi>t</mi>
        <mi>i</mi>
        <mi>o</mi>
        <msub>
            <mi>n</mi>
            <mi>x</mi>
        </msub>
        <mo>,</mo>
        <mi>p</mi>
        <mi>o</mi>
        <mi>s</mi>
        <mi>i</mi>
        <mi>t</mi>
        <mi>i</mi>
        <mi>o</mi>
        <msub>
            <mi>n</mi>
            <mi>y</mi>
        </msub>
        <mo>,</mo>
        <mi>s</mi>
        <mi>q</mi>
        <mi>r</mi>
        <mi>t</mi>
        <mo stretchy="false">(</mo>
        <mi>v</mi>
        <mi>e</mi>
        <mi>l</mi>
        <mi>o</mi>
        <mi>c</mi>
        <mi>i</mi>
        <mi>t</mi>
        <msubsup>
            <mi>y</mi>
            <mi>x</mi>
            <mn>2</mn>
        </msubsup>
        <mo>+</mo>
        <mi>v</mi>
        <mi>e</mi>
        <mi>l</mi>
        <mi>o</mi>
        <mi>c</mi>
        <mi>i</mi>
        <mi>t</mi>
        <msubsup>
            <mi>y</mi>
            <mi>y</mi>
            <mn>2</mn>
        </msubsup>
        <mo stretchy="false">)</mo>
        <mo stretchy="false">]</mo>
        </math>

    1. 定义雅可比矩阵:

        状态转移函数F的雅可比矩阵和测量函数H的雅可比矩阵用于线性化EKF中使用的非线性方程。它们的计算方法如下:

        F = 
        <math xmlns="http://www.w3.org/1998/Math/MathML">
        <mrow>
            <mo>[</mo>
            <mtable>
            <mtr>
                <mtd><mn>1</mn></mtd>
                <mtd><mn>0</mn></mtd>
                <mtd><mi>dt</mi></mtd>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>0</mn></mtd>
            </mtr>
            <mtr>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>1</mn></mtd>
                <mtd><mn>0</mn></mtd>
                <mtd><mi>dt</mi></mtd>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>0</mn></mtd>
            </mtr>
            <mtr>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>1</mn></mtd>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>0</mn></mtd>
            </mtr>
            <mtr>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>1</mn></mtd>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>0</mn></mtd>
            </mtr>
            <mtr>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>1</mn></mtd>
                <mtd><mn>0</mn></mtd>
            </mtr>
            <mtr>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>1</mn></mtd>
            </mtr>
            </mtable>
            <mo>]</mo>
        </mrow>
        </math>

        H = 
        <math xmlns="http://www.w3.org/1998/Math/MathML">
        <mrow>
            <mo>[</mo>
            <mtable>
            <mtr>
                <mtd><mn>1</mn></mtd>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>0</mn></mtd>
            </mtr>
            <mtr>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>1</mn></mtd>
                <mtd>
                <mfrac>
                    <m>
                    <mi>v</mi>
                    <mi>e</mi>
                    <mi>l</mi>
                    <mi>o</mi>
                    <mi>c</mi>
                    <mi>i</mi>
                    <mi>t</mi>
                    <msub>
                        <mi>y</mi>
                        <mi>x</mi>
                    </msub>
                    </m>
                    <msqrt>
                    <msup>
                        <m>
                    <mi>v</mi>
                    <mi>e</mi>
                    <mi>l</mi>
                    <mi>o</mi>
                    <mi>c</mi>
                    <mi>i</mi>
                    <mi>t</mi>
                    <msub>
                        <mi>y</mi>
                        <mi>x</mi>
                    </msub>
                    </m>
                        <mn>2</mn>
                    </msup>
                    <mo>+</mo>
                    <msup>
                        <m>
                    <mi>v</mi>
                    <mi>e</mi>
                    <mi>l</mi>
                    <mi>o</mi>
                    <mi>c</mi>
                    <mi>i</mi>
                    <mi>t</mi>
                    <msub>
                        <mi>y</mi>
                        <mi>y</mi>
                    </msub>
                    </m>
                        <mn>2</mn>
                    </msup>
                    </msqrt>
                </mfrac>
                </mtd>
                <mtd>
                <mfrac>
                                        <m>
                    <mi>v</mi>
                    <mi>e</mi>
                    <mi>l</mi>
                    <mi>o</mi>
                    <mi>c</mi>
                    <mi>i</mi>
                    <mi>t</mi>
                    <msub>
                        <mi>y</mi>
                        <mi>x</mi>
                    </msub>
                    </m>
                    <msqrt>
                    <msup>
                        <m>
                    <mi>v</mi>
                    <mi>e</mi>
                    <mi>l</mi>
                    <mi>o</mi>
                    <mi>c</mi>
                    <mi>i</mi>
                    <mi>t</mi>
                    <msub>
                        <mi>y</mi>
                        <mi>y</mi>
                    </msub>
                    </m>
                        <mn>2</mn>
                    </msup>
                    <mo>+</mo>
                    <msup>
                        <m>
                    <mi>v</mi>
                    <mi>e</mi>
                    <mi>l</mi>
                    <mi>o</mi>
                    <mi>c</mi>
                    <mi>i</mi>
                    <mi>t</mi>
                    <msub>
                        <mi>y</mi>
                        <mi>y</mi>
                    </msub>
                    </m>
                        <mn>2</mn>
                    </msup>
                    </msqrt>
                </mfrac>
                </mtd>
                <mtd><mn>0</mn></mtd>
                <mtd><mn>0</mn></mtd>
            </mtr>
            </mtable>
            <mo>]</mo>
        </mrow>
        </math>

    1. 定义过程噪声和测量噪声矩阵:
        
        过程噪声矩阵Q和测量噪声矩阵R分别用于对系统和传感器中的不确定性进行建模。假设汽车的位置和速度不相关，我们可以将Q和R定义为对角矩阵:

        Q =  
        <math xmlns="http://www.w3.org/1998/Math/MathML"> 
        <mrow> 
            <mo>[</mo> 
            <mtable> 
            <mtr> 
                <mtd><mfrac><msup><mi>dt</mi><mn>4</mn></msup><mn>4</mn></mfrac></mtd> 
                <mtd><mn>0</mn></mtd> 
                <mtd><mfrac><msup><mi>dt</mi><mn>3</mn></msup><mn>2</mn></mfrac></mtd> 
                <mtd><mn>0</mn></mtd> 
                <mtd><mn>0</mn></mtd> 
                <mtd><mn>0</mn></mtd> 
            </mtr> 
            <mtr> 
                <mtd><mn>0</mn></mtd> 
                <mtd><mfrac><msup><mi>dt</mi><mn>4</mn></msup><mn>4</mn></mfrac></mtd> 
                <mtd><mn>0</mn></mtd> 
                <mtd><mfrac><msup><mi>dt</mi><mn>3</mn></msup><mn>2</mn></mfrac></mtd> 
                <mtd><mn>0</mn></mtd> 
                <mtd><mn>0</mn></mtd> 
            </mtr> 
            <mtr> 
                <mtd><mfrac><msup><mi>dt</mi><mn>3</mn></msup><mn>2</mn></mfrac></mtd> 
                <mtd><mn>0</mn></mtd> 
                <mtd><msup><mi>dt</mi><mn>2</mn></msup></mtd> 
                <mtd><mn>0</mn></mtd> 
                <mtd><mn>0</mn></mtd> 
                <mtd><mn>0</mn></mtd> 
            </mtr> 
            <mtr> 
                <mtd><mn>0</mn></mtd> 
                <mtd><mfrac><msup><mi>dt</mi><mn>3</mn></msup><mn>2</mn></mfrac></mtd> 
                <mtd><mn>0</mn></mtd> 
                <mtd><msup><mi>dt</mi><mn>2</mn></msup></mtd> 
                <mtd><mn>0</mn></mtd> 
                <mtd><mn>0</mn></mtd> 
            </mtr> 
            <mtr> 
                <mtd><mn>0</mn></mtd> 
                <mtd><mn>0</mn></mtd> 
                <mtd><mn>0</mn></mtd> 
                <mtd><mn>0</mn></mtd> 
                <mtd><mi>speed_variance</mi></mtd> 
                <mtd><mn>0</mn></mtd> 
            </mtr> 
            <mtr> 
                <mtd><mn>0</mn></mtd> 
                <mtd><mn>0</mn></mtd> 
                <mtd><mn>0</mn></mtd> 
                <mtd><mn>0</mn></mtd> 
                <mtd><mn>0</mn></mtd> 
                <mtd><mi>speed_variance</mi></mtd> 
            </mtr> 
            </mtable> 
            <mo>]</mo> 
        </mrow> 
        </math> 
        
        R =  
        <math xmlns="http://www.w3.org/1998/Math/MathML"> 
        <mrow> 
            <mo>[</mo> 
            <mtable> 
            <mtr> 
                <mtd><mi>gps_variance</mi></mtd> 
                <mtd><mn>0</mn></mtd> 
                <mtd><mn>0</mn></mtd> 
            </mtr> 
            <mtr> 
                <mtd><mn>0</mn></mtd> 
                <mtd><mi>gps_variance</mi></mtd> 
                <mtd><mn>0</mn></mtd> 
            </mtr> 
            <mtr> 
                <mtd><mn>0</mn></mtd> 
                <mtd><mn>0</mn></mtd> 
                <mtd><mi>speed_variance</mi></mtd> 
            </mtr> 
            </mtable> 
            <mo>]</mo> 
        </mrow> 
        </math>

    1. 实现EKF算法:

        初始化状态向量和协方差矩阵

        

        要使用这个函数，你需要传入以下参数:

        1. measurements: GPS列表。
        1. initial_estimate: 一个双元素列表或numpy数组，表示位置和速度的初始估计值。
        1. speed: 汽车的恒定速度，单位为米/秒。
        1. speed_variance:汽车速度的方差。
        1. gps_variance: GPS测量值的方差。