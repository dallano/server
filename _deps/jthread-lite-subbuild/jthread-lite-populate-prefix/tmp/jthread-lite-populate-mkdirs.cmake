# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "C:/Users/Atwoo/OneDrive/Documents/GitHub/server/_deps/jthread-lite-src"
  "C:/Users/Atwoo/OneDrive/Documents/GitHub/server/_deps/jthread-lite-build"
  "C:/Users/Atwoo/OneDrive/Documents/GitHub/server/_deps/jthread-lite-subbuild/jthread-lite-populate-prefix"
  "C:/Users/Atwoo/OneDrive/Documents/GitHub/server/_deps/jthread-lite-subbuild/jthread-lite-populate-prefix/tmp"
  "C:/Users/Atwoo/OneDrive/Documents/GitHub/server/_deps/jthread-lite-subbuild/jthread-lite-populate-prefix/src/jthread-lite-populate-stamp"
  "C:/Users/Atwoo/OneDrive/Documents/GitHub/server/_deps/jthread-lite-subbuild/jthread-lite-populate-prefix/src"
  "C:/Users/Atwoo/OneDrive/Documents/GitHub/server/_deps/jthread-lite-subbuild/jthread-lite-populate-prefix/src/jthread-lite-populate-stamp"
)

set(configSubDirs Debug)
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "C:/Users/Atwoo/OneDrive/Documents/GitHub/server/_deps/jthread-lite-subbuild/jthread-lite-populate-prefix/src/jthread-lite-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "C:/Users/Atwoo/OneDrive/Documents/GitHub/server/_deps/jthread-lite-subbuild/jthread-lite-populate-prefix/src/jthread-lite-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()
