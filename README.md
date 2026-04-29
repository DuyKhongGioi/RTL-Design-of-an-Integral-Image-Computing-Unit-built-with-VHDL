# **An RTL Design of Integral Image Compute Block**
---
## **I. Introduction**

In this project, an implementation for the Integral Image function (as well **`integralImage()`** in MatLab).
The following section demonstrates a visualization of this function:
Denote I as the input matrix with size 5x5:
**$$
I = \begin{bmatrix}
17 & 24 & 1 & 8 & 15\\
23 & 5 & 7 & 14 & 16\\
4 & 6 & 13 & 20 & 22\\
10 & 12 & 19 & 21 & 3\\
11 & 18 & 25 & 2 & 9\\
\end{bmatrix}
$$**

then the output is a 6x6 matrix, which is ***each element is the sum of current element in the input matrix and all previous output elements that have index smaller than current output index***.

that is:
**$$
O = \begin{bmatrix}
0 & 0 & 0 & 0 & 0 & 0\\
0 & 17 & 41 & 42 & 50 & 65\\
0 & 40 & 69 & 77 & 99 & 130\\
0 & 44 & 79 & 100 & 142 & 195\\
0 & 54 & 101 & 141 & 204 & 260\\
0 & 65 & 130 & 195 & 260 & 325\\
\end{bmatrix}
$$**

So to summarize, we have the formula of the **Integral Image** is:
$$
Im\_out[r][c] = 0, \text{ r = 0 or c = 0}
$$
$$Im\_out[r][c] = Im\_in[r - 1][c - 1] + Im\_out[r - 1][c] + Im\_out[r][c - 1] - Im\_out[r - 1][c - 1]$$

For example, considers the **Im_out** element at index ``[2][2]``:
$$Im\_out[2][2] = 5 + 23 + 24 + 17 = 5 +  40 + 41 - 17 = 5 + (17 + 23) + (17 + 24) - (17)$$

# **II. Design Specification**
1. **IntegralImage** block can interface with **CPU** so that CPU can configure:
    - the `base_address` of the **Input Image**, which have size `NxM` range from `5x5` to `256x256`. 
    - the `base_address` of the memory region that stores the **Output Image**.
2. **CPU** triggers the compute procedure of the **IntegralImage** block by sending the `start` signal.
3. After the computing compeleted, **IntegralImage** block imforms the status by sending the `done` signal.
4. In computing process, **Memory** will send the input pixel by pixel, **CPU** recieves and informs the **IntegralImage** to compute the correspond output pixel, then **CPU** write it to specific memory slot. 
![Figure 1: Block Diagram of the design](https://s3.hedgedoc.org/hd1-demo/uploads/a42dbdbd-1a92-429a-86e6-3ed611a23e47.png)
$$
\text{Figure 1: Block Diagram of the design}
$$

### **I/O Interface Declarations**
**Bảng 1: Mô tả các tín hiệu vào ra**

| TT | Port        | Direction | Width  | Meaning                                      |
|----|------------|-----------|--------|----------------------------------------------|
| 1  | Start      | In        | 1 bit  | Tín hiệu ra lệnh bắt đầu tính toán           |
| 2  | Clock      | In        | 1 bit  | Tín hiệu xung nhịp điều khiển hệ thống       |
| 3  | Reset      | In        | 1 bit  | Tín hiệu đặt lại hệ thống về trạng thái ban đầu |
| 4  | Done       | Out       | 1 bit  | Tín hiệu báo hiệu kết thúc tính toán         |
| 5  | In_pixel   | In        | 23 bit | Pixel hiện tại từ ảnh đầu vào                |
| 6  | Address_out| Out       | 18 bit | Địa chỉ ghi đầu ra hiện tại                  |
| 7  | Out_pixel  | Out       | 23 bit | Pixel ảnh đầu ra tương ứng hiện tại          |

## **III. Implementation**
This section demonstrates my design for **IntegralImage** block details above.

### **Pseudo Code**

```
    Function IntegralImage(Imin[M][N], Imout[M+1][N+1])
    Initialize window[3] = {0}
    Initialize line[N + 1] = {0}

    For row = 0 → M:
        For col = 0 → N:

            window[0] ← window[1]
            window[1] ← line[col]

            If row < 1 OR col < 1 then
                Imout[row][col] ← 0
            Else
                Imout[row][col] ← Imin[row-1][col-1]
                                   + window[2]
                                   + window[1]
                                   - window[0]

            window[2] ← Imout[row][col]
            line[col] ← Imout[row][col]

        EndFor
    EndFor
EndFunction
```
### **Datapath**
![](https://s3.hedgedoc.org/hd1-demo/uploads/ec08739b-fbed-41e4-b9aa-0fa798103416.png)


