package com.go.wherego.trip.model.service;

import java.util.ArrayList;

import com.go.wherego.trip.model.vo.PageInfo;
import com.go.wherego.trip.model.vo.Trip;

public interface TripService {

	//지역별 데이터 저장
	int saveArea(ArrayList<Trip> list);
	
	//여행지 전체 개수
	int listCount();
	
	//지역별 여행지 전체 개수
	int areaListCount(String areaCode);
	
	//여행지 목록 조회
	ArrayList<Trip> selectList(PageInfo pi);
	
	//지역 별 목록 조회
	ArrayList<Trip> selectAreaList(PageInfo pi, String areaCode);

	//조회수 증가
	int increaseCount(String contentId);
	
	//조회수 조회
	int selectCount(String contentId);
}
