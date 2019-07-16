! Program :
! Author  : wansooha@gmail.com
! Date    :

        program test_cfg_read
        use cfgio_mod
        implicit none
        type(cfg_t):: cfg
        integer n1
        integer,allocatable:: n1a(:)
        real o1
        real,allocatable:: o1a(:)
        real(kind=8) d1
        real(kind=8),allocatable:: d1a(:)
        character(len=16):: label2
        character(len=16),allocatable:: label2a(:)
        logical use_swd
        logical,allocatable:: la(:)
        complex c1
        complex,allocatable:: c1a(:)
        complex(kind=8):: c2
        complex(kind=8),allocatable:: c2a(:)
        integer i,npar
        print*,'parse cfg'
        cfg=parse_cfg("test.cfg")
        print*,'n sect=',cfg%nsect()
        print*,'read i'
        call cfg%get("DEFAULTS","n1",n1)
        call cfg%get("DEFAULTS","n1a",n1a,npar)
        print*,'npar=',npar
        print*,'read f'
        call cfg%get("sec 01",'o1',o1)
        call cfg%get("sec 01",'o1a',o1a,npar)
        print*,'npar=',npar
        call cfg%get("sec 01",'d1',d1)
        call cfg%get("sec 01",'d1a',d1a,npar)
        print*,'npar=',npar
        print*,'read s'
        call cfg%get("sec 01",'label2',label2)
        call cfg%get("sec 01",'label2a',label2a,npar)
        print*,'npar=',npar
        print*,'read b'
        call cfg%get("sec 02",'use swd',use_swd)
        call cfg%get("sec 02",'la',la,npar)
        print*,'npar=',npar
        print*,'read c'
        call cfg%get("sec 03",'c1',c1)
        call cfg%get("sec 03",'c1a',c1a,npar)
        print*,'npar=',npar
        print*,'read z'
        call cfg%get("sec 03",'c2',c2)
        call cfg%get("sec 03",'c2a',c2a,npar)
        print*,'npar=',npar
        print*,'read end'

        print*,'n1=',n1
        print*,'n1a=',n1a
        print*,'o1=',o1
        print*,'o1a=',o1a
        print*,'d1=',d1
        print*,'d1a=',d1a
        print*,'label2=',trim(label2)
        do i=1,size(label2a)
            print*,'label2a=',i,label2a(i)
        enddo
        print*,'use swd=',use_swd
        print*,'la=',la
        print*,'c1',c1
        print*,'c1a',c1a
        print*,'c2',c2
        print*,'c2a',c2a
        call cfg%write()

        end

