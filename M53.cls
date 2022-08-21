Class M53 Extends %RegisteredObject
{

/// d ##class(M.M53).Match(0,32,"CC")
/// d ##class(M.M53).Match(97, 123, "LL")
ClassMethod Match(start, end, prop)
{
	for i = start : 1 : end {
		if ($match($char(i), "\p{" _ prop _ "}")){
			w i, "符合", $char(i),!
		} else{
			w i, "不符合",!
		}   
	}
	s a =1
}

/// d ##class(M.M53).Match1(48,58,"digit")
/// d ##class(M.M53).Match(48, 90, "alnum")
ClassMethod Match1(start, end, prop)
{
	for i = start : 1 : end {
		if ($match($char(i), "[:" _ prop _ ":]")){
			w i, "符合", $char(i),!
		} else{
			w i, "不符合",!
		}
	}
}

/// d ##class(M.M53).Match2()
ClassMethod Match2()
{
	w $match("1315456498151561651","[0-9]+"),!
	w $match("1315456498151561651","([0-9])+"),!
	w $match("Call me my name Yao","\p{LU}(\p{L}|\s)+"),!
	w $match("1^23^456^7890","([0-9]+\^?)+"),!
	w $match("$1,23,4567,890.99","^\$([0-9]+,?)+\.[:digit:]{2}"),!
}

/// d ##class(M.M53).Match3()
ClassMethod Match3()
{
	s t1 = $zh
	w $match("111111111,2222222222,33333333","([0-9]+,?)+"),!
	w $zh - t1,!
	
	s t1 = $zh
	w $match("1111x1111,2222222222,33333333","([0-9]+,?)+"),!
	w $zh - t1,!
	
	s t1 = $zh
	w $match("111111111,22x2222222,33333333","([0-9]+,?)+"),!
	w $zh - t1,!
	
	s t1 = $zh
	w $match("111111111,2222222x22,33333333","([0-9]+,?)+"),!
	w $zh - t1,!
	
	s t1 = $zh
	w $match("111111111,2222222222,3x333333","([0-9]+,?)+"),!
	w $zh - t1,!
	
	s t1 = $zh
	w $match("111111111,2222222222,33x33333","([0-9]+,?)+"),!
	w $zh - t1,!
}

/// d ##class(M.M53).Match4()
ClassMethod Match4()
{
	s str(1) = "爱你"         
	s str(2) = "我 爱你"  
	s str(3) = "你 爱我"    
	s str(4) = "你爱我"    
	s str(5) = "我爱你"     
	s str(6) = "我 爱 你"  
	s str(7) = "你 爱 我" 

  	for i = 1 : 1 : 7 {
		w $match(str(i),".*\b爱[我你].*")," ",i,!
	}
}

/// d ##class(M.M53).Match5()
ClassMethod Match5()
{
	w $match("A", "\x41"),!
	w $match("姚姚姚", "\x{59DA}+"),!
}

/// d ##class(M.M53).Match6()
ClassMethod Match6()
{
	w $match("A", "\0101"),!
	w $match($c(255), "\0377"),!
}

/// d ##class(M.M53).IsChinese("姚鑫")
ClassMethod IsChinese(input)
{
	if $match(input, "[\u4e00-\u9fa5") = 1 {
		w $$$OK
	}else{
		w $$$NO
	}
}

/// d ##class(M.M53).Match7()
ClassMethod Match7()
{
	w $match($char(10), "\cK"),!
	w $match($char(13), "\cM"),!
}

/// d ##class(M.M53).Match7()
ClassMethod Match8()
{
	w $match(",", "\N{comma}"),!
	w $match(" ", "\N{space}"),!
	w $match("+", "\N{plus sign}"),!
}

/// d ##class(M.M53).Match9()
ClassMethod Match9()
{
	w $match("A", "(?i)[abc]"),!
	w $match("a", "(?i)[abc]"),!
	w $match("A", "(?-i)[abc]"),!
	w $match("a", "(?-i)[abc]"),!
}

/// d ##class(M.M53).Match10()
ClassMethod Match10()
{
	s line(1) = "My name is Yao."
	s line(2) = "My name is" _ $char(10) _"Yao."
	s line(3) = "My name" _ $char(13) _ "is" _ $char(12) _"Yao."
	s i = 1
	while $data(line(i)) {
		if $match(line(i),".*") {
			w "line(", i, ") 单行",! 
		} elseif $match(line(i),"(?s).*") {
			w "line(", i, ") 多行",! 
		} else {
			w "其他"
		}
		s i = i + 1 
	}
}

/// d ##class(M.M53).Match11()
ClassMethod Match11()
{
	s color(1) = "red"
	s color(2) = "green"
	s color(3) = "Blue"
	s i = 1
	while $data(color(i)) {
		w $match(color(i),"(?i:re|gre|bl)\p{L}{1,2}")," = ",color(i),!
		s i = i + 1 
	}
}

/// d ##class(M.M53).Match12()
ClassMethod Match12()
{
 	w $match("2022-06-19","^\d{4}-[01]\d\[0123]\d$")
}

/// d ##class(M.M53).Match13()
ClassMethod Match13()
{
   w $match("2022-06-19","^\d\d\d\d\-[01]\d\-[012]\d$"),"无注解",!
   w $match("2022-06-19","^\d\d\d\d\-[01]\d\-[012]\d$ # 匹配日期格式（YYYY-MM-DD）")," (?x) 没有启动，注解无效",!
   w $match("2022-06-19","(?x)^\d\d\d\d\-[01]\d\-[012]\d$ # 匹配日期格式（YYYY-MM-DD）"),"在(?x)模式下注释",!
}

/// d ##class(M.M53).Match14()
ClassMethod Match14()
{
	try {
		s str="yx"
		w $match(str,"\p{}")
	}
	catch exp {
		s ret = ##class(%Regex.Matcher).LastStatus()
		zw ret
		d $SYSTEM.Status.DisplayError(ret) 
	}
}

/// d ##class(M.M53).Match15()
ClassMethod Match15()
{
}

}
