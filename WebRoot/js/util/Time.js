function JsonTimeToString(jsonTime){
	var re= "";
	if(jsonTime!=null){
		re = (jsonTime['year'] + 1900)
	+ '-'
	+ (jsonTime['month'] + 1)
	+ '-' + jsonTime['date']
	+ ' '
	+ jsonTime['hours'] + ":"
	+ jsonTime['minutes'] + ":"
	+ (jsonTime['seconds']=='0'?"00":jsonTime['seconds']);
	}
	return re;
}