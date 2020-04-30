package com.smwb.vo;

public class CategoryCountVo {
	private String categoryItem;
	private Integer count;
	public String getCategoryItem() {
		return categoryItem;
	}
	public void setCategoryItem(String categoryItem) {
		this.categoryItem = categoryItem;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	@Override
	public String toString() {
		return "CatogoryCountVo [categoryItem=" + categoryItem + ", count=" + count + "]";
	}

}
