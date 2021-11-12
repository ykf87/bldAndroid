package com.jiankang.gouqi.util;


import androidx.recyclerview.widget.RecyclerView;

import java.util.Observer;

/**
 * Created by air on 2019/3/14.
 */
public interface ICountDownCenter {
    void addObserver(Observer observer);
    void deleteObservers();
    void startCountdown();
    void stopCountdown();
    boolean containHolder(Observer observer);
    void notifyAdapter();
    void bindRecyclerView(RecyclerView recyclerView);
}
