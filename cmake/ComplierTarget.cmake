include(CheckSymbolExists)

function(detect_architecture symbol arch)
	if (NOT DEFINED ARCHITECTURE)
		set(CMAKE_REQUIRED_QUIET 1)
		check_symbol_exists("${symbol}" "" ARCHITECTURE_${arch})
		unset(CMAKE_REQUIRED_QUIET)
	

		if (ARCHITECTURE_${arch})
			set(ARCHITECTURE "${arch}" PARENT_SCOPE)
			set(ARCHITECTURE_${arch} 1 PARENT_SCOPE)
			add_definitions(-DARCHITECTURE_${arch}=1)

		endif()

	endif()

endfunction()
