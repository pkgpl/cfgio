! Program :
! Author  : wansooha@gmail.com
! Date    :

        program test_cfg_write
        use cfgio_mod
        implicit none
        type(cfg_t):: cfg
        character(len=128):: str
        integer n
        cfg=parse_cfg("test_intpl.cfg")
        call cfg.get("section 2",'n',n)
        print*,'n=',n
        call cfg.get("section1",'intpl',str)
        print*,'intpl='//trim(str)
        call cfg.get("section1",'fs',str)
        print*,'fs='//trim(str)
        str=cfg.gets("section 2",'fi')
        print*,'fi='//trim(str)
        call cfg.get("section 2",'fv',str)
        print*,'fv='//trim(str)

        call cfg.write()

        end

