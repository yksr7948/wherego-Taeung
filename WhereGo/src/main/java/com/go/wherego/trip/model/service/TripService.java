package com.go.wherego.trip.model.service;

import java.util.ArrayList;

import com.go.wherego.trip.model.vo.PageInfo;
import com.go.wherego.trip.model.vo.Trip;

public interface TripService {

	//지역별 데이터 저장
	int saveArea(ArrayList<Trip> list);
	
	//여행지 전체 개수
	int listCount();
	
	//여행지 목록 조회
	ArrayList<Trip> selectList(PageInfo pi);
}
