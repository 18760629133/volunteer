package com.wwl.utils;

import org.springframework.stereotype.Component;

import java.util.Calendar;

@Component
public class Time {
	public String getTime(){
		Calendar cal=Calendar.getInstance();
		int y=cal.get(Calendar.YEAR);
		int m=cal.get(Calendar.MONTH)+1;
		int d=cal.get(Calendar.DATE);
		int h=cal.get(Calendar.HOUR_OF_DAY);
		int mi=cal.get(Calendar.MINUTE);
		int s=cal.get(Calendar.SECOND);
		String time=y+"-"+m+"-"+d+" "+h+":"+mi+":"+s;
		return time;
	}
	public String getDay(){
		Calendar cal=Calendar.getInstance();
		int y=cal.get(Calendar.YEAR);
		int m=cal.get(Calendar.MONTH)+1;
		int d=cal.get(Calendar.DATE);
		String time=y+"-"+m+"-"+d;
		return time;
	}
	public String getYear(){
		Calendar cal=Calendar.getInstance();
		int y=cal.get(Calendar.YEAR);
		String time=y+"-";
		return time;
	}
}
