package=rust
$(package)_version=1.26.0
$(package)_download_path=https://static.rust-lang.org/dist
$(package)_file_name_linux=rust-$($(package)_version)-x86_64-unknown-linux-gnu.tar.gz
$(package)_sha256_hash_linux=13691d7782577fc9f110924b26603ade1990de0b691a3ce2dc324b4a72a64a68
$(package)_file_name_darwin=rust-$($(package)_version)-x86_64-apple-darwin.tar.gz
$(package)_sha256_hash_darwin=38708803c3096b8f101d1919ee2d7e723b0adf1bc1bb986b060973b57d8c7c28

$(package)_rust_target_mingw32=x86_64-pc-windows-gnu
$(package)_file_name_mingw32=rust-$($(package)_version)-x86_64-pc-windows-gnu.tar.gz
$(package)_sha256_hash_mingw32=4586d69edcb22f7ebd651cd305dce67ead065e8a60994a7d64fc8b472fc4e51b

$(package)_rust_target_arm=arm-unknown-linux-gnueabihf
$(package)_file_name_arm=rust-$($(package)_version)-arm-unknown-linux-gnueabihf.tar.gz
$(package)_sha256_hash_arm=10e1c03e8e86f9357615befa5b0ddc32cdf3c85e1e019d7225850be3b3c3da91

define $(package)_cross_compile_fetch_cmds
$(call fetch_file,$(package),$($(package)_download_path),$($(package)_download_file),$($(package)_file_name),$($(package)_sha256_hash)) && \
$(call fetch_file,$(package),$($(package)_download_path),$($(package)_file_name_$(build_os)),$($(package)_file_name_$(build_os)),$($(package)_sha256_hash_$(build_os)))
endef

define $(package)_cross_compile_extract_cmds
  mkdir -p $($(package)_extract_dir) && \
  echo "$($(package)_sha256_hash)  $($(package)_source)" > $($(package)_extract_dir)/.$($(package)_file_name).hash && \
  echo "$($(package)_sha256_hash_$(build_os))  $($(package)_source_dir)/$($(package)_file_name_$(build_os))" >> $($(package)_extract_dir)/.$($(package)_file_name).hash && \
  $(build_SHA256SUM) -c $($(package)_extract_dir)/.$($(package)_file_name).hash && \
  mkdir $(1) && \
  tar --strip-components=1 -xf $($(package)_source) -C $(1) && \
  mkdir buildos && \
  tar --strip-components=1 -xf $($(package)_source_dir)/$($(package)_file_name_$(build_os)) -C buildos
endef

define $(package)_cross_compile_stage_cmds
  ./install.sh --destdir=$($(package)_staging_dir) --prefix=$(host_prefix)/native --disable-ldconfig && \
  cp -r ../$(1)/rust-std-$(2)/lib/rustlib/$(2) $($(package)_staging_dir)$(host_prefix)/native/lib/rustlib
endef

ifeq ($(host_os),mingw32)
$(package)_build_subdir=buildos
$(package)_extra_sources = $($(package)_file_name_$(build_os))

define $(package)_fetch_cmds
  $(call $(package)_cross_compile_fetch_cmds)
endef

define $(package)_extract_cmds
  $(call $(package)_cross_compile_extract_cmds,$(host_os))
endef

define $(package)_stage_cmds
  $(call $(package)_cross_compile_stage_cmds,$(host_os),$($(package)_rust_target_$(host_os)))
endef

else ifeq ($(host_arch),arm)
$(package)_build_subdir=buildos
$(package)_extra_sources = $($(package)_file_name_$(build_os))

define $(package)_fetch_cmds
  $(call $(package)_cross_compile_fetch_cmds)
endef

define $(package)_extract_cmds
  $(call $(package)_cross_compile_extract_cmds,$(host_arch))
endef

define $(package)_stage_cmds
  $(call $(package)_cross_compile_stage_cmds,$(host_arch),$($(package)_rust_target_$(host_arch)))
endef
else

define $(package)_stage_cmds
  ./install.sh --destdir=$($(package)_staging_dir) --prefix=$(host_prefix)/native --disable-ldconfig
endef
endif
