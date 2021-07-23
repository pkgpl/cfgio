! Program :
! Author  : wansooha@gmail.com
! Date    :

        program test_cfg_read
        use cfgio_mod
        implicit none
        type(cfg_t):: cfg
        integer,allocatable:: a(:)
        real,allocatable:: b(:)
        print*,'parse cfg'
        cfg=parse_cfg("test_arr.cfg")
        print*,'n sect=',cfg%nsect()
        print*,'read i'
        call cfg%get("section1","a",a)
        call cfg%get("section1","b",b)
        print*,'a=',a
        print*,'b=',b
        call cfg%finalize()

        end

