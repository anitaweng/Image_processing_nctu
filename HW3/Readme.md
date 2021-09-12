# Laplacian filtering
This work finds the Fourier magnitude spectra of the of a image after applying Laplacian filtering.
The requirements are described in 'project 3 20200422.pdf'.
Executing hw3_0510894.m in MATLAB can obtain the results.

Replace 'Bird 1.tif' with your input image name in hw3_0510894.m.
```
Img=im2double(imread('Bird 1.tif'));
```

Origin:

![image](https://user-images.githubusercontent.com/42642215/132979365-c6024405-db9d-4474-850c-e728f444c940.png)

Fourier magnitude spectra of the bird image after applying Laplacian filtering:

![Fourier after laplacian filter](https://user-images.githubusercontent.com/42642215/132979552-97599735-f8e3-46c2-900c-0dc7f06feeb7.png)

![Fourier after laplacian filter(using log)](https://user-images.githubusercontent.com/42642215/132979557-190665ac-a83f-4f3e-8a44-4e8b57af3375.png)

Figure of the Fourier magnitude of Laplacian filter H(u,v):

![Laplacian filter H(u,v)](https://user-images.githubusercontent.com/42642215/132979565-6635e9d2-b952-4bd9-83b0-425c16e2428e.png)

Figure of the output image:

![Figure of the output image_times_255](https://user-images.githubusercontent.com/42642215/132979577-8cea97de-15f2-46fd-9c9d-1a96c7864042.png)
