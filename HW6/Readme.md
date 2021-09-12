This work applies Canny edge detection algorithm to the image.
The requirements are described in 'project 6 2020-06-01.pdf'.
Executing hw6_0510894.m in MATLAB can obtain the results.

Replace 'image-pj6(Canny).tif' with your input image name in hw6_0510894.m.
```
Img=im2double(imread('image-pj6(Canny).tif'));
```

Origin:

![image](https://user-images.githubusercontent.com/42642215/132983896-aebee31f-e0aa-4f20-9a21-6e7c206eab54.png)

Figures of the gradient magnitude(normalized)and gradient angle (normalized)images:

![Gradient magnitude](https://user-images.githubusercontent.com/42642215/132983936-f63101b8-af0f-45d8-b19a-b2f68cbe4b69.png)

![Gradient angle](https://user-images.githubusercontent.com/42642215/132983952-40de4dab-b742-4880-9957-cf8988097ace.png)

Figures of gNL(x, y) (normalized) and gNH(x, y) (normalized):

![gnL](https://user-images.githubusercontent.com/42642215/132984008-d9547117-ba51-4a29-8714-75072cd1478a.png)

![gnH](https://user-images.githubusercontent.com/42642215/132984013-06f76f7e-6b77-4183-84a1-501d93541073.png)

Figure of final edge map:

![Final edge map](https://user-images.githubusercontent.com/42642215/132984025-e74eaf54-bd58-4d89-879d-bda8e849e082.png)
