package com.go.wherego.trans.model.service;

import java.util.ArrayList;

import com.go.wherego.trans.model.vo.Terminal;



public interface TransService {

	int saveTerminalInfo(ArrayList<Terminal> list);

	String getTerminalCode(String termianlNm);

}
