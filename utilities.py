import numpy as np

def apply_cut(arr, varname, lower=None, upper=None):
    sub_arr = np.copy(arr)
    mask = np.ones(sub_arr.shape[0], dtype=bool)
    if lower is not None: mask &= (sub_arr[varname] >= lower)
    if upper is not None: mask &= (sub_arr[varname] <= upper)
    sub_arr = sub_arr[mask]
    return sub_arr

def deduce_epid_ord(epid_bits):

    # Levels: 0, 1, 2, 3, 4, 5, 6
    SuperLoose = (epid_bits >> (6 + 0)) & 1
    VeryLoose = (epid_bits >> (6 + 1)) & 1
    Loose = (epid_bits >> (6 + 2)) & 1
    Tight = (epid_bits >> (6 + 3)) & 1
    VeryTight = (epid_bits >> (6 + 4)) & 1
    SuperTight = (epid_bits >> (6 + 5)) & 1

    return (SuperLoose + VeryLoose + Loose +
            Tight + VeryTight + SuperTight)

def deduce_mpid_ord(mpid_bits):

    # Levels: 0, 1, 2, 3, 4
    VeryLooseFakeRate = (mpid_bits >> (20 + 0)) & 1
    LooseFakeRate = (mpid_bits >> (20 + 1)) & 1
    TightFakeRate = (mpid_bits >> (20 + 2)) & 1
    VeryTightFakeRate = (mpid_bits >> (20 + 3)) & 1

    return (VeryLooseFakeRate + LooseFakeRate +
            TightFakeRate + VeryTightFakeRate)

def apply_pid_deduction(arr):
    pid_arr = arr['tag_l_epid'].astype(int)
    arr['tag_l_epid'] = np.apply_along_axis(deduce_epid_ord, 0, pid_arr)
    pid_arr = arr['sig_h_epid'].astype(int)
    arr['sig_h_epid'] = np.apply_along_axis(deduce_epid_ord, 0, pid_arr)
    pid_arr = arr['tag_l_mupid'].astype(int)
    arr['tag_l_mupid'] = np.apply_along_axis(deduce_mpid_ord, 0, pid_arr)
    pid_arr = arr['sig_h_mupid'].astype(int)
    arr['sig_h_mupid'] = np.apply_along_axis(deduce_mpid_ord, 0, pid_arr)
