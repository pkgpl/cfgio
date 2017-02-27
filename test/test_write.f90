! Program :
! Author  : wansooha@gmail.com
! Date    :

        program test_cfg_write
        use cfgio_mod
        implicit none
        type(cfg_t):: cfg
        integer:: n1=10,n1a(5)=(/1,2,3,4,5/)
        real:: o1=0.01,o1a(5)=(/1.,2.,3.,4.,5./)
        real(kind=8):: d1=0.01d0,d1a(4)=(/1.d0,2.d0,3.d0,4.d0/)
        character(len=16):: label2='Distance (km)',label2a(4)=(/'str1','s t r 2','str 3','string,  4'/)
        logical:: use_swd=.false.,la(5)=(/.true.,.true.,.true.,.false.,.false./)
        complex:: c1=cmplx(0.,1.),c1a(4)=(/cmplx(0.,1.),cmplx(0.,2.),cmplx(0.,3.),cmplx(0.,4.)/)
        complex(kind=8):: c2=dcmplx(0.d0,1.d0),c2a(3)=(/dcmplx(0.,1.),dcmplx(0.,2.),dcmplx(0.,3.)/)
        call cfg.set("DEFAULTS","n1",n1)
        call cfg.set("DEFAULTS","n1a",n1a)
        call cfg.set("sec 01",'o1',o1)
        call cfg.set("sec 01",'o1a',o1a)
        call cfg.set("sec 01",'d1',d1)
        call cfg.set("sec 01",'d1a',d1a)
        call cfg.set("sec 01",'label2',trim(label2))
        call cfg.set("sec 01",'label2a',label2a)
        call cfg.set("sec 02",'use swd',use_swd)
        call cfg.set("sec 02",'la',la)
        call cfg.set("sec 03",'c1',c1)
        call cfg.set("sec 03",'c1a',c1a)
        call cfg.set("sec 03",'c2',c2)
        call cfg.set("sec 03",'c2a',c2a)

        call cfg.write('test.cfg')

        end

