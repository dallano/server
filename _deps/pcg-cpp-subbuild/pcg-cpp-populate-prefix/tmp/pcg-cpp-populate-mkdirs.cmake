# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "C:/Users/Atwoo/OneDrive/Documents/GitHub/server/_deps/pcg-cpp-src"
  "C:/Users/Atwoo/OneDrive/Documents/GitHub/server/_deps/pcg-cpp-build"
  "C:/Users/Atwoo/OneDrive/Documents/GitHub/server/_deps/pcg-cpp-subbuild/pcg-cpp-populate-prefix"
  "C:/Users/Atwoo/OneDrive/Documents/GitHub/server/_deps/pcg-cpp-subbuild/pcg-cpp-populate-prefix/tmp"
  "C:/Users/Atwoo/OneDrive/Documents/GitHub/server/_deps/pcg-cpp-subbuild/pcg-cpp-populate-prefix/src/pcg-cpp-populate-stamp"
  "C:/Users/Atwoo/OneDrive/Documents/GitHub/server/_deps/pcg-cpp-subbuild/pcg-cpp-populate-prefix/src"
  "C:/Users/Atwoo/OneDrive/Documents/GitHub/server/_deps/pcg-cpp-subbuild/pcg-cpp-populate-prefix/src/pcg-cpp-populate-stamp"
)

set(configSubDirs Debug)
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "C:/Users/Atwoo/OneDrive/Documents/GitHub/server/_deps/pcg-cpp-subbuild/pcg-cpp-populate-prefix/src/pcg-cpp-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "C:/Users/Atwoo/OneDrive/Documents/GitHub/server/_deps/pcg-cpp-subbuild/pcg-cpp-populate-prefix/src/pcg-cpp-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()
