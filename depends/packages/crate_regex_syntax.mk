package=crate_regex_syntax
$(package)_crate_name=regex-syntax
$(package)_version=0.6.12
$(package)_download_path=https://static.crates.io/crates/$($(package)_crate_name)
$(package)_file_name=$($(package)_crate_name)-$($(package)_version).crate
$(package)_sha256_hash=11a7e20d1cce64ef2fed88b66d347f88bd9babb82845b2b858f3edbf59a4f716
$(package)_crate_versioned_name=$($(package)_crate_name)

define $(package)_preprocess_cmds
  $(call generate_crate_checksum,$(package))
endef

define $(package)_stage_cmds
  $(call vendor_crate_source,$(package))
endef
