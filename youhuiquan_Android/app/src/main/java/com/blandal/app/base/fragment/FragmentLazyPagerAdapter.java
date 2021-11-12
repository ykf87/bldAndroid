package com.blandal.app.base.fragment;

import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentPagerAdapter;

import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;

/**
 * 懒加载
 *
 * @author: ljx
 * @createDate: 2020/9/16 10:59
 */
public class FragmentLazyPagerAdapter extends FragmentPagerAdapter {
    private ArrayList<Fragment> mFragments;
    private String[] mTitles;

    public FragmentLazyPagerAdapter(@NotNull FragmentManager fragmentManager, @NotNull ArrayList<Fragment> fragments, @NotNull String[] titles) {
        super(fragmentManager, BEHAVIOR_RESUME_ONLY_CURRENT_FRAGMENT);
        mFragments = fragments;
        mTitles = titles;
    }

    @NotNull
    @Override
    public Fragment getItem(int position) {
        return mFragments.get(position);
    }


    @Override
    public int getCount() {
        return mFragments.size();
    }

    @Override
    public CharSequence getPageTitle(int position) {
        if (mTitles.length > position) {
            return mTitles[position];
        }
        return mTitles[mTitles.length-1];
    }

    public void notifyDataSetChanged(ArrayList<Fragment> fragments, String[] titles) {
        mFragments = fragments;
        mTitles = titles;
        super.notifyDataSetChanged();
    }
}
