package com.blandal.app.ui.my.adpter;

import android.util.SparseArray;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentStatePagerAdapter;

import java.lang.ref.WeakReference;
import java.util.List;

import com.blandal.app.ui.my.fragment.MyTaskFragment;

/**
 * 我的任务分类
 */

public class MyTaskClassifyAdapter extends FragmentStatePagerAdapter {
    private SparseArray<WeakReference<Fragment>> registeredFragments = new SparseArray<WeakReference<Fragment>>();
    private List<Integer> mList;
    private long mEntryId;

    public MyTaskClassifyAdapter(@NonNull FragmentManager fm) {
        super(fm);
    }

    public MyTaskClassifyAdapter(@NonNull FragmentManager fm, List<Integer> list) {
        super(fm);
        mList = list;
    }

    @Override
    public Fragment getItem(int position) {
        return MyTaskFragment.newInstance(mList.get(position));
    }

    @Override
    public Object instantiateItem(ViewGroup container, int position) {
        // 得到缓存的fragment
        MyTaskFragment fragment = (MyTaskFragment) super.instantiateItem(container, position);
        WeakReference<Fragment> weak = new WeakReference<Fragment>(fragment);
        registeredFragments.put(position, weak);
        return fragment;
    }

    @Override
    public void destroyItem(ViewGroup container, int position, Object object) {
        registeredFragments.remove(position);
        super.destroyItem(container, position, object);
    }

    @Override
    public int getCount() {
        return mList == null?0:mList.size();
    }

    public void remove(int position) {
        mList.remove(position);
        notifyDataSetChanged();
    }

    @Override
    public int getItemPosition(Object object) {
        return POSITION_NONE;
    }

}
