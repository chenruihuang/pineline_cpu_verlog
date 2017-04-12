/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000002758195454_3258266500_init();
    work_m_00000000000015137617_0610666722_init();
    work_m_00000000001175688830_1200043877_init();
    work_m_00000000001801786660_0924832676_init();
    work_m_00000000001467628967_2038303166_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000001467628967_2038303166");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}