package com.nuri.shopping.model;

import lombok.Data;

public class excelVO {
  private String idx;
  private String content;
  
  public String getIdx() {
    return idx;
  }
  public String setIdx(String idx) {
    return this.idx = idx;
  }
  
  public String getContent() {
    return content;
  }
  public String setContent(String content) {
    return this.content = content;
  }
  
}
