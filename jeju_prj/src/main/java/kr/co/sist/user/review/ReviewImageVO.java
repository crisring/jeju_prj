package kr.co.sist.user.review;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewImageVO {
    private int review_id;
    private String img_name;

    public ReviewImageVO() {}

    public ReviewImageVO(int review_id, String imgName) {
        this.review_id = review_id;
        this.img_name = imgName;
    }
}