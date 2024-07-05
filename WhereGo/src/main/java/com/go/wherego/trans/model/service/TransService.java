package com.go.wherego.trans.model.service;

import java.util.ArrayList;

import com.go.wherego.trans.model.vo.GTerminal;
import com.go.wherego.trans.model.vo.Instant;
import com.go.wherego.trans.model.vo.STerminal;
import com.go.wherego.trans.model.vo.Train;



public interface TransService {

	int saveGTerminalInfo(ArrayList<GTerminal> list);

	String getGTerminalCode(String GtermianlNm);

	int saveSTerminalInfo(ArrayList<STerminal> list);

	String getSTerminalCode(String SterminalNm);

	ArrayList<String> likeSearch(String title);

	int insertInstant(ArrayList<Instant> list);

	ArrayList<String> arriavlLikeSearch(String title);

	int deleteInstant();
	
	ArrayList<Train> getArea();

}
