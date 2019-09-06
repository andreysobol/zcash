package=crate_regex_automata
$(package)_crate_name=regex-automata
$(package)_version=0.1.8
$(package)_download_path=https://static.crates.io/crates/$($(package)_crate_name)
$(package)_file_name=$($(package)_crate_name)-$($(package)_version).crate
$(package)_sha256_hash=92b73c2a1770c255c240eaa4ee600df1704a38dc3feaa6e949e7fcd4f8dc09f9
$(package)_crate_versioned_name=$($(package)_crate_name)

define $(package)_preprocess_cmds
  $(call generate_crate_checksum,$(package))
endef

define $(package)_stage_cmds
  $(call vendor_crate_source,$(package))
endef
