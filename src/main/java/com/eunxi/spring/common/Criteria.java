package com.eunxi.spring.common;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Criteria {
    private int page;
    private int amount;

    public Criteria(){
        this(1, 10);
    }

    public Criteria(int page, int amount){
        this.page = page;
        this.amount = amount;
    }
}
