package com.smwb.po;

public class Category {
    private Integer cid;

    private String categoryItem;

	public Integer getCid() {
		return cid;
	}

	public void setCid(Integer cid) {
		this.cid = cid;
	}

	public String getCategoryItem() {
		return categoryItem;
	}

	public void setCategoryItem(String categoryItem) {
		this.categoryItem = categoryItem;
	}

	@Override
	public String toString() {
		return "Category [cid=" + cid + ", categoryItem=" + categoryItem + "]";
	}
    
}