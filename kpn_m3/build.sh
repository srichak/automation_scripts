#!/bin/bash

WORKING_DIR=temp
cd ../
CUR_DIR=$(pwd)

echo "Starting delete dir ${CUR_DIR}/${WORKING_DIR}"

rm -rf "${CUR_DIR}/${WORKING_DIR}"

outputDelet=$?

if [ $outputDelet -ne 0 ]
then
   echo "Command delete ${OLD_DIR}/${WORKING_DIR}  is not properly terminated"
   exit 1
fi


#pwd

if [ "${AVS_BUILDTYPE_CONF}" = "true" ]
then
      if [ ! -d conf ] && [ $(ls conf/ | wc -l) -eq 0 ]
      then
	echo "Directory conf doesn't exists or directory empty"
	exit 1
      else
	  #cd ../
          #echo "Sono nel conf"
	  CUR_DIR=$(pwd)
	  echo "Starting zip  ${CUR_DIR}/conf"
	  find conf/ -type d -name .svn -prune -o -print | zip -uq conf_${BUILD_NUMBER}.zip -@
#          zip -rq "conf_${BUILD_NUMBER}.zip" conf/*
        
          outputzip=$?
          if [ $outputzip -ne 0 ]
          then
      	   echo "Command zip is not properly terminated"
      	   exit 1
          fi
	
	  mkdir -p ${CUR_DIR}/${WORKING_DIR}/conf
    
	  echo "Starting move ${CUR_DIR}/conf_${BUILD_NUMBER}.zip into ${CUR_DIR}/${WORKING_DIR}/conf"
          mv conf_${BUILD_NUMBER}.zip ${CUR_DIR}/${WORKING_DIR}/conf
    
          outputmove=$?
          if [ $outputmove -ne 0 ]
          then
    	   echo "Command move is not properly terminated"
    	   exit 1
          fi
    
          cd ${CUR_DIR}/${WORKING_DIR}/

	  echo "Starting zip all file in ${CUR_DIR}/${WORKING_DIR}/ naming ${JOB_NAME##*/}"_REL_"${AVS_RELEASE_NUMBER}.zip"
          zip -rq ${JOB_NAME##*/}"_REL_"${AVS_RELEASE_NUMBER}.zip *
          
          outputzip=$?
          if [ $outputzip -ne 0 ]
          then
    	   echo "Command zip is not properly terminated"
    	   exit 1
          fi
      fi
	cd ../ 	
fi


if [ "${AVS_BUILDTYPE_SQL}" = "true" ]
then
	#echo "Sono nel sql"
	
	if [ ! -d sql ] && [ $(ls sql/ | wc -l ) -eq 0 ]
 	then
	    echo "Directory sql doesn't exists or empty"
	    exit 1
	else
		#cd ../
		CUR_DIR=$(pwd)
		echo "Starting zip ${CUR_DIR}/sql"
        	#zip -rq "sql_${BUILD_NUMBER}.zip" sql/*
		 find sql/ -type d -name .svn -prune -o -print | zip -uq sql_${BUILD_NUMBER}.zip -@

        	outputzip=$?
        	if [ $outputzip -ne 0 ]
              	then
        	   echo "Command zip is not properly terminated"
        	   exit 1
              	fi

		mkdir -p ${CUR_DIR}/${WORKING_DIR}/sql
            	
		echo "Starting move ${CUR_DIR}/sql_${BUILD_NUMBER}.zip into ${CUR_DIR}/${WORKING_DIR}/sql"
        	mv sql_${BUILD_NUMBER}.zip ${CUR_DIR}/${WORKING_DIR}/sql
        	
        	outputmove=$?
              	if [ $outputmove -ne 0 ]
              	then
        	   echo "Command move is not properly terminated"
        	   exit 1
              	fi
        
        	cd ${CUR_DIR}/${WORKING_DIR}/

		echo "Starting zip all file in ${CUR_DIR}/${WORKING_DIR}/ naming ${JOB_NAME##*/}"_REL_"${AVS_RELEASE_NUMBER}.zip"
              	zip -rq ${JOB_NAME##*/}"_REL_"${AVS_RELEASE_NUMBER}.zip *
          	outputzip=$?
              	if [ $outputzip -ne 0 ]
              	then
        	   echo "Command zip is not properly terminated"
        	   exit 1
              	fi
	fi
	cd ../ 	
fi

if [ "${AVS_BUILDTYPE_LIB}" = "true" ]
then
	#echo "Sono nel lib"
	if [ ! -d lib ] && [ $(ls lib/ | wc -l) -eq 0 ]
	then
	    echo "Directory lib doesn't exists"
	    exit 1
	else
		#cd ../
		CUR_DIR=$(pwd)
		echo "Starting zip ${CUR_DIR}/lib"	
		
        	#zip -rq "lib_${BUILD_NUMBER}.zip" lib/*
		find lib/ -type d -name .svn -prune -o -print | zip -uq lib_${BUILD_NUMBER}.zip -@
        	outputzip=$?
        	if [ $outputzip -ne 0 ]
              	then
        	   echo "Command zip is not properly terminated"
                   exit 1
              	fi
	
		mkdir -p ${CUR_DIR}/${WORKING_DIR}/lib
        
		echo "Starting move ${CUR_DIR}/lib_${BUILD_NUMBER}.zip into ${CUR_DIR}/${WORKING_DIR}/lib"

            	mv lib_${BUILD_NUMBER}.zip ${CUR_DIR}/${WORKING_DIR}/lib
        	outputmove=$?
        	if [ $outputmove -ne 0 ]
              	then
        	   echo "Command move is not properly terminated"
                   exit 1
              	fi
        
        	cd ${CUR_DIR}/${WORKING_DIR}/

		echo "Starting zip all file in ${CUR_DIR}/${WORKING_DIR}/ naming ${JOB_NAME##*/}"_REL_"${AVS_RELEASE_NUMBER}.zip"

              	zip -rq ${JOB_NAME##*/}"_REL_"${AVS_RELEASE_NUMBER}.zip *
        	outputzip=$?
        	if [ $outputzip -ne 0 ]
              	then
        	   echo "Command zip is not properly terminated"
        	   exit 1
              	fi
	fi
	cd ../	
fi

if [ "${AVS_BUILDTYPE_DIST}" = "true" ]
then
	#echo "Sono nel dist"
	if [ ! -d dist ] && [ $(ls dist/ | wc -l) -eq 0 ]
	then
	    echo "Directory dist doesn't exists"
	    exit 1
	else
		#cd ../
		CUR_DIR=$(pwd)
		echo "Starting zip ${CUR_DIR}/dist"
	
        	#zip -rq "dist_${BUILD_NUMBER}.zip" dist/*
		find dist/ -type d -name .svn -prune -o -print | zip -uq dist_${BUILD_NUMBER}.zip -@
        	outputzip=$?
        	if [ $outputzip -ne 0 ]
              	then
        	   echo "Command zip is not properly terminated"
                   exit 1
              	fi
        	
		mkdir -p ${CUR_DIR}/${WORKING_DIR}/dist
		
		echo "Starting move ${CUR_DIR}/dist_${BUILD_NUMBER}.zip into ${CUR_DIR}/${WORKING_DIR}/dist"

              	mv dist_${BUILD_NUMBER}.zip ${CUR_DIR}/${WORKING_DIR}/dist
        	
        	outputmove=$?
        	if [ $outputmove -ne 0 ]
              	then
        	   echo "Command move is not properly terminated"
        	   exit 1
              	fi
        	cd ${CUR_DIR}/${WORKING_DIR}/

		echo "Starting zip all file in ${CUR_DIR}/${WORKING_DIR}/ naming ${JOB_NAME##*/}"_REL_"${AVS_RELEASE_NUMBER}.zip"

              	zip -rq ${JOB_NAME##*/}"_REL_"${AVS_RELEASE_NUMBER}.zip *
        	outputzip=$?
        	if [ $outputzip -ne 0 ]
              	then
        	   echo "Command zip is not properly terminated"
        	   exit 1
              	fi	
	fi
	cd ../
fi

if [ "${AVS_BUILDTYPE_EXE}" = "true" ]
then
	#echo "Sono nel exe"
	if [ ! -d exe ] && [ $(ls exe/ | wc -l) -eq 0 ]
	then
	    echo "Directory exe doesn't exists"
	    exit 1
	else
		#cd ../
		CUR_DIR=$(pwd)
		echo "Starting zip ${CUR_DIR}/exe"		

        	#zip -rq "exe_${BUILD_NUMBER}.zip" exe/*     
		find exe/ -type d -name .svn -prune -o -print | zip -uq exe_${BUILD_NUMBER}.zip -@
        	outputzip=$?
        	if [ $outputzip -ne 0 ]
              	then
        	   echo "Command zip is not properly terminated"
              	   exit 1
              	fi 

		mkdir -p ${CUR_DIR}/${WORKING_DIR}/exe

		echo "Starting move ${CUR_DIR}/exe_${BUILD_NUMBER}.zip into ${CUR_DIR}/${WORKING_DIR}/exe"

              	mv exe_${BUILD_NUMBER}.zip ${CUR_DIR}/${WORKING_DIR}/exe
        	outputmove=$?
        	if [ $outputmove -ne 0 ]
              	then
        	   echo "Command move is not properly terminated"
        	   exit 1
              	fi
        	cd ${CUR_DIR}/${WORKING_DIR}/
	
		echo "Starting zip all file in ${CUR_DIR}/${WORKING_DIR}/ naming ${JOB_NAME##*/}"_REL_"${AVS_RELEASE_NUMBER}.zip"

              	zip -rq ${JOB_NAME##*/}"_REL_"${AVS_RELEASE_NUMBER}.zip *
        	outputzip=$?
        	if [ $outputzip -ne 0 ]
              	then
        	   echo "Command zip is not properly terminated"
        	   exit 1
              	fi	
	fi
	cd ../
fi

if [ "${AVS_BUILDTYPE_FULL}" = "true" ]
then
	#echo "Sono nel full"

	#cd ../
	CUR_DIR=$(pwd)
	if [ -d conf ] && [ $(ls conf/ | wc -l) -ne 0 ]
	then
	    
	    echo "Starting zip ${CUR_DIR}/conf"
	
	    #zip -rq "conf_${BUILD_NUMBER}.zip" conf/*
	    find conf/ -type d -name .svn -prune -o -print | zip -uq conf_${BUILD_NUMBER}.zip -@
	    outputzip=$?
	    if [ $outputzip -ne 0 ]
	    then
	    	echo "Command zip is not properly terminated"
	     fi
	    	#ls -lart
	    
	    mkdir -p ${CUR_DIR}/${WORKING_DIR}/conf

	    echo "Starting move ${CUR_DIR}/conf_${BUILD_NUMBER}.zip into ${CUR_DIR}/${WORKING_DIR}/conf"	

	    mv conf_${BUILD_NUMBER}.zip ${CUR_DIR}/${WORKING_DIR}/conf      	
	    outputmove=$?
	    if [ $outputmove -ne 0 ]
	    then
	        echo "Command move is not properly terminated"
	    fi 	
	fi	

      	
	if [ -d sql ] && [ $(ls sql/ | wc -l) -ne 0 ]
	then
		echo "Starting zip ${CUR_DIR}/sql"		

	    	#zip -rq "sql_${BUILD_NUMBER}.zip" sql/*
		find sql/ -type d -name .svn -prune -o -print | zip -uq sql_${BUILD_NUMBER}.zip -@
		outputzip=$?
		if [ $outputzip -ne 0 ]
      		then
		     echo "Command zip is not properly terminated"
      		fi
      	
		mkdir -p ${CUR_DIR}/${WORKING_DIR}/sql

		echo "Starting move ${CUR_DIR}/sql_${BUILD_NUMBER}.zip into ${CUR_DIR}/${WORKING_DIR}/sql"	

		mv sql_${BUILD_NUMBER}.zip ${CUR_DIR}/${WORKING_DIR}/sql
      		outputmove=$?
		if [ $outputmove -ne 0 ]
      		then
	 	  	echo "Command move is not properly terminated"
      		fi
	fi

	if [ -d lib ] && [ $(ls lib/ | wc -l) -ne 0 ]
	then
		echo "Starting zip ${CUR_DIR}/lib"
		
	    	#zip -rq "lib_${BUILD_NUMBER}.zip" lib/*
		find lib/ -type d -name .svn -prune -o -print | zip -uq lib_${BUILD_NUMBER}.zip -@
		outputzip=$?
		if [ $outputzip -ne 0 ]
      		then
	   	     echo "Command zip is not properly terminated"
      		fi

		mkdir -p ${CUR_DIR}/${WORKING_DIR}/lib

		echo "Starting move ${CUR_DIR}/lib_${BUILD_NUMBER}.zip into ${CUR_DIR}/${WORKING_DIR}/lib" 
      	
		mv lib_${BUILD_NUMBER}.zip ${CUR_DIR}/${WORKING_DIR}/lib
 		outputmove=$?
		if [ $outputmove -ne 0 ]
      		then
	   	     echo "Command move is not properly terminated"
      		fi     	
	fi

	if [ -d dist ] && [ $(ls dist/ | wc -l) -ne 0 ]
	then
		echo "Starting zip ${CUR_DIR}/dist"
	
		#zip -rq "dist_${BUILD_NUMBER}.zip" dist/*
		find dist/ -type d -name .svn -prune -o -print | zip -uq dist_${BUILD_NUMBER}.zip -@
      		outputzip=$?
		if [ $outputzip -ne 0 ]
      		then
	   		echo "Command zip is not properly terminated"
		fi

		mkdir -p ${CUR_DIR}/${WORKING_DIR}/dist

		echo "Starting move ${CUR_DIR}/dist_${BUILD_NUMBER}.zip into ${CUR_DIR}/${WORKING_DIR}/dist" 

	   	mv dist_${BUILD_NUMBER}.zip ${CUR_DIR}/${WORKING_DIR}/dist
	   	outputmove=$?
	   	if [ $outputmove -ne 0 ]
      	   	then
	   		echo "Command move is not properly terminated"
      	   	fi
	fi
	
	if [ -d exe ] && [ $(ls exe/ | wc -l) -ne 0 ]
	then
	    echo "Starting zip ${CUR_DIR}/exe"	
		
  	    #zip -rq "exe_${BUILD_NUMBER}.zip" exe/*
	    find exe/ -type d -name .svn -prune -o -print | zip -uq exe_${BUILD_NUMBER}.zip -@
      	    outputzip=$?
	    if [ $outputzip -ne 0 ]
      	    then
	       echo "Command zip is not properly terminated"
      	    fi
	    
	    mkdir -p ${CUR_DIR}/${WORKING_DIR}/exe

	    echo "Starting move ${CUR_DIR}/exe_${BUILD_NUMBER}.zip into ${CUR_DIR}/${WORKING_DIR}/exe" 

	    mv exe_${BUILD_NUMBER}.zip ${CUR_DIR}/${WORKING_DIR}/exe
	    outputmove=$?
	    if [ $outputmove -ne 0 ]
      	    then
	         echo "Command move is not properly terminated"
	    fi
      	fi
	cd ${CUR_DIR}/${WORKING_DIR}/
	pwd
 	
	echo "Starting zip all file in ${CUR_DIR}/${WORKING_DIR}/ naming ${JOB_NAME##*/}"_REL_"${AVS_RELEASE_NUMBER}.zip"

	zip -rq ${JOB_NAME##*/}"_REL_"${AVS_RELEASE_NUMBER}.zip *
      	outputzip=$?
      	if [ $outputzip -ne 0 ]
	then
         	echo "Command zip is not properly terminated"
	fi	
fi