package com.jiankang.gouqi.ui.main.adapter;

import android.util.SparseArray;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentStatePagerAdapter;

import java.lang.ref.WeakReference;
import java.util.List;

import com.jiankang.gouqi.ui.main.entity.ClassifyBean;
import com.jiankang.gouqi.ui.main.fragment.HomeTaskFragment;

public class HomeClassifyAdapter extends FragmentStatePagerAdapter {
    private SparseArray<WeakReference<Fragment>> registeredFragments = new SparseArray<WeakReference<Fragment>>();
    private List<ClassifyBean> mList;
    private long mEntryId;

    public HomeClassifyAdapter(@NonNull FragmentManager fm) {
        super(fm);
    }

    public HomeClassifyAdapter(@NonNull FragmentManager fm, List<ClassifyBean> list) {
        super(fm);
        mList = list;
    }

    @Override
    public Fragment getItem(int position) {
        return HomeTaskFragment.newInstance(mList.get(position).getId());
    }

    @Override
    public Object instantiateItem(ViewGroup container, int position) {
        // 得到缓存的fragment
        HomeTaskFragment fragment = (HomeTaskFragment) super.instantiateItem(container, position);
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

    @Nullable
    @Override
    public CharSequence getPageTitle(int position) {
        return mList.get(position).getName();
    }
}
