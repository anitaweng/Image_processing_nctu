This work constructs N-superpixel images.
The requirements are described in 'project 7 2020-06-08.pdf'.
Executing hw7_0510894.m in MATLAB can obtain the results.

Replace 'image-pj7c.tif' with your input image name in hw7_0510894.m.
```
Img=im2double(imread('image-pj7c.tif'));
```

Origin:

![image](https://user-images.githubusercontent.com/42642215/132984128-8b2b30dd-89a2-4670-906e-b8b412a21ede.png)

Figures of 400 superpixel images for c=1 and c=10:

![400 superpixel   c=1](https://user-images.githubusercontent.com/42642215/132984158-d04141f2-c700-4182-9c90-f9c279964868.png)

![400 superpixel   c=10](https://user-images.githubusercontent.com/42642215/132984172-603ca7ec-8baa-4ce2-a843-2ba56edb308e.png)

Figures of 100 superpixel images for c=1 and c=10:

![100 superpixel   c=1](https://user-images.githubusercontent.com/42642215/132984229-16991ad2-cdde-4391-92db-b5238ac042b1.png)

![100 superpixel   c=10](https://user-images.githubusercontent.com/42642215/132984235-85b2f295-3825-45fb-b79b-7800f572d365.png)

Difference images between each of the four superpixel image and the original image:

![400 superpixel   c=1 origin-result difference](https://user-images.githubusercontent.com/42642215/132984259-fff27ebe-151b-4b12-8919-779d79c6a5c7.png)

![400 superpixel   c=10 origin-result difference](https://user-images.githubusercontent.com/42642215/132984267-26a38aa1-11ff-42e2-bc52-297cb9381796.png)

![100 superpixel   c=1 origin-result difference](https://user-images.githubusercontent.com/42642215/132984269-379a4162-0e66-4c09-9069-86c87a71de5a.png)

![100 superpixel   c=10 origin-result difference](https://user-images.githubusercontent.com/42642215/132984278-e0206500-ac48-4707-8a08-1f4a871986c5.png)

