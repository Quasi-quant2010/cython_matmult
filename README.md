cythonを用いた行列計算の高速化について  
  
1. Pure Python  
2. Python + Numpy  
3. Cython + Class + Malloc  
4. Cython + Function  
5. Cython Function + Typed Memoryviews and Raw Pointer  
6. Cython Class +  Typed Memoryviews  
  
[結果]  
1. 2 function calls in 100.808 seconds    
2. 2 function calls in 0.090 seconds  
3. 106 function calls in 17.667 seconds  
4. 3 function calls in 0.522 seconds  
5. 5 function calls in 0.209 seconds  
6. 203 function calls in 0.870 seconds  
  
当然のようにNumpyが最速である。  
従って、行列計算はNumpyを使え!(OpenBLASかGotoBLASでマルチコア化)となる。  
他方、次位となるのは5である。まあ、データ配列にポインターでアクセスしたので、早くなって当然なのだが、コードが読みづらい?  
どうしてもClassを使い場合は6のようにすればよいだろう。  
  
[参考]  
・NumPyが物足りない人へのCython入門  
http://www.slideshare.net/lucidfrontier45/cython-intro  
https://github.com/tokyo-scipy/archive/tree/master/003/cython_intro/final  
・Memoryview Benchmarks  
http://jakevdp.github.io/blog/2012/08/08/memoryview-benchmarks/  
