package com.project.commonModel.util;

import java.io.File;
import java.util.Date;
import java.util.Iterator;

import org.apache.poi.hssf.usermodel.DVConstraint;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataValidation;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddressList;
import org.apache.poi.hssf.util.Region;
public class POIUtil {  
//  /**  
//   * 把一个excel中的cellstyletable复制到另一个excel，这里会报错，不能用这种方法，不明白呀？？？？？  
//   * @param fromBook  
//   * @param toBook  
//   */  
//  public static void copyBookCellStyle(HSSFWorkbook fromBook,HSSFWorkbook toBook){  
//      for(short i=0;i<fromBook.getNumCellStyles();i++){  
//          HSSFCellStyle fromStyle=fromBook.getCellStyleAt(i);  
//          HSSFCellStyle toStyle=toBook.getCellStyleAt(i);  
//          if(toStyle==null){  
//              toStyle=toBook.createCellStyle();  
//          }  
//          copyCellStyle(fromStyle,toStyle);  
//      }  
//  }  
    /** 
     * 复制一个单元格样式到目的单元格样式 
     * @param fromStyle 
     * @param toStyle 
     */  
    public static void copyCellStyle(HSSFCellStyle fromStyle,  
            HSSFCellStyle toStyle) {  
        toStyle.setAlignment(fromStyle.getAlignment());  
        //边框和边框颜色  
        toStyle.setBorderBottom(fromStyle.getBorderBottom());  
        toStyle.setBorderLeft(fromStyle.getBorderLeft());  
        toStyle.setBorderRight(fromStyle.getBorderRight());  
        toStyle.setBorderTop(fromStyle.getBorderTop());  
        toStyle.setTopBorderColor(fromStyle.getTopBorderColor());  
        toStyle.setBottomBorderColor(fromStyle.getBottomBorderColor());  
        toStyle.setRightBorderColor(fromStyle.getRightBorderColor());  
        toStyle.setLeftBorderColor(fromStyle.getLeftBorderColor());  
          
        //背景和前景  
        toStyle.setFillBackgroundColor(fromStyle.getFillBackgroundColor());  
        toStyle.setFillForegroundColor(fromStyle.getFillForegroundColor());  
          
        toStyle.setDataFormat(fromStyle.getDataFormat());  
        toStyle.setFillPattern(fromStyle.getFillPattern());  
//      toStyle.setFont(fromStyle.getFont(null));  
        toStyle.setHidden(fromStyle.getHidden());  
        toStyle.setIndention(fromStyle.getIndention());//首行缩进  
        toStyle.setLocked(fromStyle.getLocked());  
        toStyle.setRotation(fromStyle.getRotation());//旋转  
        toStyle.setVerticalAlignment(fromStyle.getVerticalAlignment());  
        toStyle.setWrapText(fromStyle.getWrapText());  
          
    }  
    /** 
     * Sheet复制 
     * @param fromSheet 
     * @param toSheet 
     * @param copyValueFlag 
     */  
    public static void copySheet(HSSFWorkbook wb,HSSFSheet fromSheet, HSSFSheet toSheet,  
            boolean copyValueFlag) {  
        //合并区域处理  
        mergerRegion(fromSheet, toSheet);  
        for (Iterator rowIt = fromSheet.rowIterator(); rowIt.hasNext();) {  
            HSSFRow tmpRow = (HSSFRow) rowIt.next();  
            HSSFRow newRow = toSheet.createRow(tmpRow.getRowNum());  
            //行复制  
            copyRow(wb,tmpRow,newRow,copyValueFlag);  
        }  
    }  
    /** 
     * 行复制功能 
     * @param fromRow 
     * @param toRow 
     */  
    public static void copyRow(HSSFWorkbook wb,HSSFRow fromRow,HSSFRow toRow,boolean copyValueFlag){ 
    	int i=0;
        for (Iterator cellIt = fromRow.cellIterator(); cellIt.hasNext();) {  
        	HSSFCell tmpCell = (HSSFCell) cellIt.next();  
            HSSFCell newCell = toRow.createCell(tmpCell.getCellNum());  
            copyCell(wb,tmpCell, newCell, copyValueFlag); 
        }  
    }  
    /** 
    * 复制原有sheet的合并单元格到新创建的sheet 
    *  
    * @param sheetCreat 新创建sheet 
    * @param sheet      原有的sheet 
    */  
    public static void mergerRegion(HSSFSheet fromSheet, HSSFSheet toSheet) {  
       int sheetMergerCount = fromSheet.getNumMergedRegions();  
       for (int i = 0; i < sheetMergerCount; i++) {  
        Region mergedRegionAt = fromSheet.getMergedRegionAt(i);  
        toSheet.addMergedRegion(mergedRegionAt);  
       }  
    }  
    /** 
     * 复制单元格 
     *  
     * @param srcCell 
     * @param distCell 
     * @param copyValueFlag 
     *            true则连同cell的内容一起复制 
     */  
    public static void copyCell(HSSFWorkbook wb,HSSFCell srcCell, HSSFCell distCell,  
            boolean copyValueFlag) {  
        HSSFCellStyle newstyle=wb.createCellStyle();  
        copyCellStyle(srcCell.getCellStyle(), newstyle);  
//        distCell.setEncoding(srcCell.getEncoding());  
        //样式  
        distCell.setCellStyle(newstyle);  
        //评论  
        if (srcCell.getCellComment() != null) {  
            distCell.setCellComment(srcCell.getCellComment());  
        }  
        // 不同数据类型处理  
        int srcCellType = srcCell.getCellType();  
        distCell.setCellType(srcCellType);  
        if (copyValueFlag) {  
            if (srcCellType == HSSFCell.CELL_TYPE_NUMERIC) {  
                if (HSSFDateUtil.isCellDateFormatted(srcCell)) {  
                    distCell.setCellValue(srcCell.getDateCellValue());  
                } else {  
                    distCell.setCellValue(srcCell.getNumericCellValue());  
                }  
            } else if (srcCellType == HSSFCell.CELL_TYPE_STRING) {  
                distCell.setCellValue(srcCell.getRichStringCellValue());  
            } else if (srcCellType == HSSFCell.CELL_TYPE_BLANK) {  
                // nothing21  
            } else if (srcCellType == HSSFCell.CELL_TYPE_BOOLEAN) {  
                distCell.setCellValue(srcCell.getBooleanCellValue());  
            } else if (srcCellType == HSSFCell.CELL_TYPE_ERROR) {  
                distCell.setCellErrorValue(srcCell.getErrorCellValue());  
            } else if (srcCellType == HSSFCell.CELL_TYPE_FORMULA) {  
                distCell.setCellFormula(srcCell.getCellFormula());  
            } else { // nothing29  
            }  
        }  
    }  
    

    
     /******************************************
     * 整合项目中两个POIUtil.java文件
     ******************************************/

	 /** 
    * 使用已定义的数据源方式设置一个下拉列表数据验证 
    * @param formulaString 
    * @param naturalRowIndex 
    * @param naturalColumnIndex 
    * @return 
    */  
   public static HSSFDataValidation getDataValidationByFormula(String formulaString,int naturalRowIndex,int naturalColumnIndex){  
       //加载下拉列表内容     
       DVConstraint constraint = DVConstraint.createFormulaListConstraint(formulaString);   
       //设置数据有效性加载在哪个单元格上。     
       //四个参数分别是：起始行、终止行、起始列、终止列     
       int firstRow = naturalRowIndex;  
       int lastRow = naturalRowIndex-1; 
       lastRow=60000;
       int firstCol = naturalColumnIndex-1;  
       firstCol =naturalColumnIndex;
       int lastCol = naturalColumnIndex-1;  
       lastCol =naturalColumnIndex;
       CellRangeAddressList regions=new CellRangeAddressList(firstRow,lastRow,firstCol,lastCol);    
       //数据有效性对象    
       HSSFDataValidation data_validation_list = new HSSFDataValidation(regions,constraint);  
       return data_validation_list;    
   }
   

	 /** 
    * 根据数字获取excel英文顺序 
    * @param currentRow 
    * @param textList 
    */  
   public static String getEnByNum(int colNum){  
      if(colNum==0){
   	   return "A";
      }else if(colNum==1){
   	   return "B";
      }else if(colNum==2){
   	   return "C";
      }else if(colNum==3){
   	   return "D";
      }else if(colNum==4){
   	   return "E";
      }else if(colNum==5){
   	   return "F";
      }else if(colNum==6){
   	   return "G";
      }else if(colNum==7){
   	   return "H";
      }else if(colNum==8){
   	   return "I";
      }else if(colNum==9){
   	   return "J";
      }else if(colNum==10){
   	   return "K";
      }else if(colNum==11){
   	   return "L";
      }else if(colNum==12){
   	   return "M";
      }else if(colNum==13){
   	   return "N";
      }else if(colNum==14){
   	   return "O";
      }else if(colNum==15){
   	   return "P";
      }else if(colNum==16){
   	   return "Q";
      }else if(colNum==17){
   	   return "R";
      }else if(colNum==18){
   	   return "S";
      }else if(colNum==19){
   	   return "T";
      }else if(colNum==20){
   	   return "U";
      }else if(colNum==21){
   	   return "V";
      }else if(colNum==22){
   	   return "W";
      }else if(colNum==23){
   	   return "X";
      }else if(colNum==24){
   	   return "Y";
      }else if(colNum==25){
   	   return "Z";
      }else if(colNum==26){
   	   return "AA";
      }else if(colNum==27){
   	   return "AB";
      }else if(colNum==28){
   	   return "AC";
      }else if(colNum==29){
   	   return "AD";
      }else if(colNum==30){
   	   return "AE";
      }else if(colNum==31){
   	   return "AF";
      }else if(colNum==32){
   	   return "AG";
      }else if(colNum==33){
   	   return "AH";
      }else if(colNum==34){
   	   return "AI";
      }else if(colNum==35){
   	   return "AJ";
      }else if(colNum==36){
   	   return "AK";
      }else if(colNum==37){
   	   return "AL";
      }else if(colNum==38){
   	   return "AM";
      }else if(colNum==39){
   	   return "AN";
      }else if(colNum==40){
   	   return "AO";
      }else if(colNum==41){
   	   return "AP";
      }else if(colNum==42){
   	   return "AQ";
      }else if(colNum==43){
   	   return "AR";
      }else if(colNum==44){
   	   return "AS";
      }else{
   	   return "";
      }  
   }
   
	public static String deleteFile(String path) {
		File file = new File(path);
		if (!file.isDirectory()) {
			file.delete();
		} else if (file.isDirectory()) {
			String[] filelist = file.list();
			Date currDate = new Date();
			Long currDates = currDate.getTime();
			for (int i = 0; i < filelist.length; i++) {
				File delfile = new File(path + "\\" + filelist[i]);
				Long lastModified = delfile.lastModified();
				String times = PropertiesUtil.getProperties("system.removefiletime", "5");
				// Calendar cal=Calendar.getInstance();
				// cal.setTimeInMillis(lastModified);
				// System.out.println(lastModified+"
				// "+cal.getTime().toLocaleString());
				Integer time = Integer.parseInt(times);
				if ((currDates - lastModified) > time * 60 * 1000) {
					delfile.delete();
				}
			}
		}
		return null;
	}
	
	  /** 
    * 创建一列数据 
    * @param currentRow 
    * @param textList 
    */  
   public static void createCol(HSSFSheet sheet,String[] textList,int colNum){  
       if(textList!=null&&textList.length>0){  
           for (int j = 0; j < textList.length; j++) {
          	 if(sheet.getRow(j)!=null){
          		 sheet.getRow(j).createCell(colNum).setCellValue(textList[j]); 
          	 }else{
          	 sheet.createRow(j).createCell(colNum).setCellValue(textList[j]); 
          	 }
			}
       }  
   }
	 /**  
    * 创建一行数据  
    * @param currentRow  
    * @param textList  
    */  
   public static void createRow(HSSFRow currentRow,String[] textList){   
       if(textList!=null&&textList.length>0){   
           int i = 0;   
           for(String cellValue : textList){   
               HSSFCell userNameLableCell = currentRow.createCell(i++);   
               userNameLableCell.setCellValue(cellValue);   
           }   
       }   
   }
} 

