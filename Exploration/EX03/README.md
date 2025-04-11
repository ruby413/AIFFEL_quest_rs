# AIFFEL Campus Online Code Peer Review Templete
- 코더 : 이주연
- 리뷰어 : 허채연


# PRT(Peer Review Template)
- [x]  **1. 주어진 문제를 해결하는 완성된 코드가 제출되었나요?**
    - 문제에서 요구하는 최종 결과물이 첨부되었는지 확인
        - 중요! 해당 조건을 만족하는 부분을 캡쳐해 근거로 첨부
     
```
# sticker_area는 원본이미지에서 스티커를 적용할 위치를 crop한 이미지 입니다.
# 좌표 순서가 y,x임에 유의한다. (y,x,rgb channel)
sticker_area = img_show[refined_y:refined_y+img_sticker.shape[0], refined_x:refined_x+img_sticker.shape[1]]
img_show[refined_y:refined_y+img_sticker.shape[0], refined_x:refined_x+img_sticker.shape[1]] = \
    np.where(img_sticker==0,img_sticker,sticker_area).astype(np.uint8)

sticker_area = img_bgr[refined_y:refined_y +img_sticker.shape[0], refined_x:refined_x+img_sticker.shape[1]]

img_bgr[refined_y:refined_y +img_sticker.shape[0], refined_x:refined_x+img_sticker.shape[1]] = \
    np.where(img_sticker==0,img_sticker,sticker_area).astype(np.uint8)
plt.imshow(cv2.cvtColor(img_bgr, cv2.COLOR_BGR2RGB))
plt.show()

```
    
- [x]  **2. 전체 코드에서 가장 핵심적이거나 가장 복잡하고 이해하기 어려운 부분에 작성된 
주석 또는 doc string을 보고 해당 코드가 잘 이해되었나요?**
    - 해당 코드 블럭을 왜 핵심적이라고 생각하는지 확인
    - 해당 코드 블럭에 doc string/annotation이 달려 있는지 확인
    - 해당 코드의 기능, 존재 이유, 작동 원리 등을 기술했는지 확인
    - 주석을 보고 코드 이해가 잘 되었는지 확인
        - 중요! 잘 작성되었다고 생각되는 부분을 캡쳐해 근거로 첨부
```
# zip() : 두 그룹의 데이터를 서로 엮어주는 파이썬의 내장 함수
# dlib_rects와 list_landmarks 데이터를 엮어 주었음
# dlib_rects : 얼굴 영역을 저장하고 있는 값
# list_landmarks : 68개의 랜드마크 값 저장(이목구비 위치(x,y))

for dlib_rect, landmark in zip(dlib_rects, list_landmarks): # 얼굴 영역을 저장하고 있는 값과 68개의 랜드마크를 저장하고 있는 값으로 반복문 실행
    print (landmark[33]) # 코 아래쪽 index는 33 입니다
    x = landmark[33][0] # 이미지에서 코 부위의 x값
    y = landmark[33][1] + dlib_rect.height()//2 # 이미지에서 코 부위의 y값 + 얼굴 영역의 세로를 차지하는 픽셀의 수//2 → (412, 509-(186+1//2))
    w = h = dlib_rect.width() # 얼굴 영역의 가로를 차지하는 픽셀의 수
    print (f'(x,y) : ({x},{y})')
    print (f'(w,h) : ({w},{h})')
```     


        
- [x]  **3. 에러가 난 부분을 디버깅하여 문제를 해결한 기록을 남겼거나
새로운 시도 또는 추가 실험을 수행해봤나요?**
    - 문제 원인 및 해결 과정을 잘 기록하였는지 확인
    - 프로젝트 평가 기준에 더해 추가적으로 수행한 나만의 시도, 
    실험이 기록되어 있는지 확인
        - 중요! 잘 작성되었다고 생각되는 부분을 캡쳐해 근거로 첨부
     
```
# 45도 각도로 위를 바라본 다른 샘플 사진으로 진행해보았다.
# 68개의 점이 나름 눈코입을 잘 지정했다. 아마 눈이 두개, 코가 한개, 입이 한개 모두 나와있어서 성공한것 같다.
# 하지만 스티커는 회전이 되지 않기 때문에 그 위에 부자연스럽게 얹어졌다.
# 기준 사진이 얼굴크기가 작은 사진이어서 해당 샘플은 얼굴크기가 큰 사진을 썼는데, 큰 사이즈의 얼굴은 크게 영향을 미치는 것 같지 않다.
sample_pic = list(uploaded.keys())[2]
img_bgr_sample = cv2.imread(sample_pic)    # OpenCV로 이미지를 불러옵니다
img_show_sample = img_bgr_sample.copy()      # 출력용 이미지를 따로 보관합니다
img_rgb_sample = cv2.cvtColor(img_bgr_sample, cv2.COLOR_BGR2RGB)
dlib_rects_sample = detector_hog(img_rgb_sample, 1)   # (image, num of image pyramid)
print(dlib_rects_sample)

for dlib_rect_sample in dlib_rects_sample: # 찾은 얼굴 영역의 좌표
    l = dlib_rect_sample.left() # 왼쪽
    t = dlib_rect_sample.top() # 위쪽
    r = dlib_rect_sample.right() # 오른쪽
    b = dlib_rect_sample.bottom() # 아래쪽

    cv2.rectangle(img_show_sample, (l,t), (r,b), (0,255,0), 2, lineType=cv2.LINE_AA) # 시작점의 좌표와 종료점 좌표로 직각 사각형을 그림

img_sample_show_rgb =  cv2.cvtColor(img_show_sample, cv2.COLOR_BGR2RGB)
plt.imshow(img_sample_show_rgb)
plt.show()
```
    
        
- [x]  **4. 회고를 잘 작성했나요?**
    - 주어진 문제를 해결하는 완성된 코드 내지 프로젝트 결과물에 대해
    배운점과 아쉬운점, 느낀점 등이 기록되어 있는지 확인
    - 전체 코드 실행 플로우를 그래프로 그려서 이해를 돕고 있는지 확인
        - 중요! 잘 작성되었다고 생각되는 부분을 캡쳐해 근거로 첨부

## <해당 부분>
배운점 : 스티커가 있는 이미지를 따로 잘라내어 붙인 부분이 신기했다.

아쉬운점 : addweight 구현을 하지 못한 부분이 아쉽다

느낀점 : 코드에 대한 구성을 더 확실히 인지하고 다양하게 활용할 수 있었으면 좋겠다. 스티커도 회전이 잘 될 수 있는 방법을 찾고싶다.

        
- [x]  **5. 코드가 간결하고 효율적인가요?**
    - 파이썬 스타일 가이드 (PEP8) 를 준수하였는지 확인
    - 코드 중복을 최소화하고 범용적으로 사용할 수 있도록 함수화/모듈화했는지 확인
        - 중요! 잘 작성되었다고 생각되는 부분을 캡쳐해 근거로 첨부


# 회고(참고 링크 및 코드 개선)
```
# 리뷰어의 회고를 작성합니다.
# 코드 리뷰 시 참고한 링크가 있다면 링크와 간략한 설명을 첨부합니다.
# 코드 리뷰를 통해 개선한 코드가 있다면 코드와 간략한 설명을 첨부합니다.
```
code peer review 하는 quest를 처음해보는데 쉽게 잘 알려주셔서 따라하기 쉬풨던것 같다. 
스티커의 회전에 대해서는 생각해보지 못했는데, 도전해보기 좋은 아이디어인것 같다!

