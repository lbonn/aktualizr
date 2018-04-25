#ifndef AKTUALIZR_SECONDARY_OPCUASERVER_SECONDARY_DELEGATE_H_
#define AKTUALIZR_SECONDARY_OPCUASERVER_SECONDARY_DELEGATE_H_

#include <opcuabridgeserver.h>
#include <uptane/tuf.h>
#include "utilities/utils.h"

#include <boost/filesystem/path.hpp>

class AktualizrSecondaryCommon;

class OpcuaServerSecondaryDelegate : public opcuabridge::ServerDelegate {
 public:
  OpcuaServerSecondaryDelegate(AktualizrSecondaryCommon*);

  void handleServerInitialized(opcuabridge::ServerModel*) override;
  void handleVersionReportRequested(opcuabridge::ServerModel*) override;
  void handleMetaDataFileReceived(opcuabridge::ServerModel*) override;
  void handleAllMetaDataFilesReceived(opcuabridge::ServerModel*) override;
  void handleDirectoryFilesSynchronized(opcuabridge::ServerModel*) override;
  void handleOriginalManifestRequested(opcuabridge::ServerModel*) override;
  void handleDirectoryFileListRequested(opcuabridge::ServerModel*) override;

 private:
  AktualizrSecondaryCommon* secondary_;
  Uptane::MetaPack received_meta_pack_;
  TemporaryDirectory ostree_sync_working_repo_dir_;
};

#endif  // AKTUALIZR_SECONDARY_OPCUASERVER_SECONDARY_DELEGATE_H_
