package com.project.commonModel.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.ListOrderedMap;

public final class ChartUtil {
	public static List getColor(){
		List list=new ArrayList();
		list.add("1D8BD1");
		list.add("fff9a7");
		list.add("F1683C");
		list.add("2AD62A");
		list.add("DBDC25");
		list.add("DBFF25");
		list.add("DBEE25");
		list.add("DBCC25");
		
		return list;
	}
	
	
	/**
	 * 获取图表展示xml
	 * @param chartTitle
	 * @param list
	 * @return
	 */
	public static String getCommonBar(String chartTitle,List<Map> list){
		String	xml ="<chart palette='2' caption='"+chartTitle+"' outCnvBaseFontSize='12' xAxisName='"+list.get(0).keySet().toArray()[0]+"' yAxisName='"+list.get(0).keySet().toArray()[1]+"' yAxisMaxValue='"+list.size()+"' shownames='1' showvalues='0' numberPrefix='' useRoundEdges='1' legendBorderAlpha='0' >";
			xml+="<categories>";
			for(Object obj:list){
				ListOrderedMap map=(ListOrderedMap) obj;
					xml+="<category label='"+map.get(list.get(0).keySet().toArray()[0])+"' />";
				}
			xml+="</categories>";
				xml+="<dataset seriesName='"+list.get(0).keySet().toArray()[1]+"' showValues='0'>";
				for(Object obj:list){
					ListOrderedMap map=(ListOrderedMap) obj;
					xml+="<set value='"+map.get(list.get(0).keySet().toArray()[1])+"' /> ";
				}
			xml+="</dataset>";
			xml+="</chart>";
			return xml;
		}
}
