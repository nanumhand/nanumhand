package kr.ac.lamda.domain;

import java.util.Date;

public class BoardVO {

  private Integer seq;
  private Integer parent;
  private Integer seq_user;
  private String title;
  private String category;
  private String content;
  private Date create_date;
  private Date modify_date;
  private int hit_view;
  private int hit_like;

  public Integer getSeq() {
	return seq;
}

public void setSeq(Integer seq) {
	this.seq = seq;
}

public Integer getParent() {
	return parent;
}

public void setParent(Integer parent) {
	this.parent = parent;
}

public Integer getSeq_user() {
	return seq_user;
}

public void setSeq_user(Integer seq_user) {
	this.seq_user = seq_user;
}

public String getTitle() {
	return title;
}

public void setTitle(String title) {
	this.title = title;
}

public String getCategory() {
	return category;
}

public void setCategory(String category) {
	this.category = category;
}

public String getContent() {
	return content;
}

public void setContent(String content) {
	this.content = content;
}

public Date getCreate_date() {
	return create_date;
}

public void setCreate_date(Date create_date) {
	this.create_date = create_date;
}

public Date getModify_date() {
	return modify_date;
}

public void setModify_date(Date modify_date) {
	this.modify_date = modify_date;
}

public int getHit_view() {
	return hit_view;
}

public void setHit_view(int hit_view) {
	this.hit_view = hit_view;
}

public int getHit_like() {
	return hit_like;
}

public void setHit_like(int hit_like) {
	this.hit_like = hit_like;
}

@Override
  public String toString() {
    return "BoardVO [seq=" + seq + ", parent=" + parent + ", seq_user=" + seq_user + ", title=" + title + 
    		", category=" + category + ", create_date=" + create_date + ", modify_date=" + modify_date + 
    		", hit_view=" + hit_view + ", hit_like=" + hit_like + ", content=" + content + "]";
  }

}
