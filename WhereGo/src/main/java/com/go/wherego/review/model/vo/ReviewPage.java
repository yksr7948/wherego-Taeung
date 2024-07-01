package com.go.wherego.review.model.vo;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewPage {
	private int listCount;
	private int currentPage;
	private int pageLimit;
	private int boardLimit;
	private int maxPage;
	private int startPage;
	private int endPage;
}
