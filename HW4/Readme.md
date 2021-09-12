# Improve the linear motion
This work finds the Fourier magnitude spectra and tries to improve the linear motion of a image.
The requirements are described in 'project 4 2020-05-11.pdf'.
Executing hw4_0510894.m in MATLAB can obtain the results.

Replace 'image-pj4 (motion blurring).tif' with your input image name in hw4_0510894.m.
```
im = im2double(imread('image-pj4 (motion blurring).tif'));
```

Origin:

![image](https://user-images.githubusercontent.com/42642215/132980074-db7e0410-7958-4800-a68c-5bb318fa1f39.png)

Figures of the Fourier magnitude spectra of the degraded image:

![degraded image](https://user-images.githubusercontent.com/42642215/132980091-e4626de0-8f8f-4ca6-a077-bcfe24f2bb17.png)

![degraded image(log)](https://user-images.githubusercontent.com/42642215/132980097-95c43a5a-22cf-461d-bf64-075a10f61e1a.png)

Figure of the Fourier magnitude of degradation model H(u,v) for uniformly linear motion blurring:

![H(u,v)](https://user-images.githubusercontent.com/42642215/132980110-6ca5e98b-0062-44e0-b1f7-79fb1e92c35a.png)

Figure of the output image:

![output](https://user-images.githubusercontent.com/42642215/132980124-3979825d-78f9-4822-9d1f-ffc05b2562bf.png)

