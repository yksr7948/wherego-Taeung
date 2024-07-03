package com.go.wherego.trans.model.service;

import java.util.ArrayList;

import com.go.wherego.trans.model.vo.GTerminal;
import com.go.wherego.trans.model.vo.STerminal;



public interface TransService {

	int saveGTerminalInfo(ArrayList<GTerminal> list);

	String getGTerminalCode(String GtermianlNm);

	int saveSTerminalInfo(ArrayList<STerminal> list);

	String getSTerminalCode(String SterminalNm);

}
