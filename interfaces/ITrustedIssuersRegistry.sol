pragma solidity 0.6.2;

import "@onchain-id/solidity/contracts/IClaimIssuer.sol";

interface ITrustedIssuersRegistry {

   /**
    *  this event is emitted when a trusted issuer is added in the registry.
    *  the event is emitted by the addTrustedIssuer function
    *  `trustedIssuer` is the address of the trusted issuer's ClaimIssuer contract
    *  `claimTopics` is the set of claims that the trusted issuer is allowed to emit
    */
    event TrustedIssuerAdded(IClaimIssuer indexed trustedIssuer, uint[] claimTopics);

   /**
    *  this event is emitted when a trusted issuer is removed from the registry.
    *  the event is emitted by the removeTrustedIssuer function
    *  `trustedIssuer` is the address of the trusted issuer's ClaimIssuer contract
    */
    event TrustedIssuerRemoved(IClaimIssuer indexed trustedIssuer);

   /**
    *  this event is emitted when the set of claim topics is changed for a given trusted issuer.
    *  the event is emitted by the updateIssuerClaimTopics function
    *  `trustedIssuer` is the address of the trusted issuer's ClaimIssuer contract
    *  `claimTopics` is the set of claims that the trusted issuer is allowed to emit
    */
    event ClaimTopicsUpdated(IClaimIssuer indexed trustedIssuer, uint[] claimTopics);

   /**
    *  @dev registers a ClaimIssuer contract as trusted claim issuer.
    *  Requires that a ClaimIssuer contract doesn't already exist
    *  Requires that the claimTopics set is not empty
    *  @param _trustedIssuer The ClaimIssuer contract address of the trusted claim issuer.
    *  @param _claimTopics the set of claim topics that the trusted issuer is allowed to emit
    *  This function can only be called by the owner of the Trusted Issuers Registry contract
    *  emits a `TrustedIssuerAdded` event
    */
    function addTrustedIssuer(IClaimIssuer _trustedIssuer, uint[] calldata _claimTopics) external;

   /**
    *  @dev Removes the ClaimIssuer contract of a trusted claim issuer.
    *  Requires that the claim issuer contract to be registered first
    *  @param _trustedIssuer the claim issuer to remove.
    *  This function can only be called by the owner of the Trusted Issuers Registry contract
    *  emits a `TrustedIssuerRemoved` event
    */
    function removeTrustedIssuer(IClaimIssuer _trustedIssuer) external;

   /**
    *  @dev Updates the set of claim topics that a trusted issuer is allowed to emit.
    *  Requires that this ClaimIssuer contract already exists in the registry
    *  Requires that the provided claimTopics set is not empty
    *  @param _trustedIssuer the claim issuer to update.
    *  @param _claimTopics the set of claim topics that the trusted issuer is allowed to emit
    *  This function can only be called by the owner of the Trusted Issuers Registry contract
    *  emits a `ClaimTopicsUpdated` event
    */
    function updateIssuerClaimTopics(IClaimIssuer _trustedIssuer, uint[] calldata _claimTopics) external;

   /**
    *  @dev Function for getting all the trusted claim issuers stored.
    *  @return array of all claim issuers registered.
    */
    function getTrustedIssuers() external view returns (IClaimIssuer[] memory);

   /**
    *  @dev Checks if the ClaimIssuer contract is trusted
    *  @param _issuer the address of the ClaimIssuer contract
    *  @return true if the issuer is trusted, false otherwise.
    */
    function isTrustedIssuer(address _issuer) external view returns(bool);

   /**
    *  @dev Function for getting all the claim topic of trusted claim issuer
    *  Requires the provided ClaimIssuer contract to be registered in the trusted issuers registry.
    *  @param _trustedIssuer the trusted issuer concerned.
    *  @return The set of claim topics that the trusted issuer is allowed to emit
    */
    function getTrustedIssuerClaimTopics(IClaimIssuer _trustedIssuer) external view returns(uint[] memory);

   /**
    *  @dev Function for checking if the trusted claim issuer is allowed
    *  to emit a certain claim topic
    *  @param _issuer the address of the trusted issuer's ClaimIssuer contract
    *  @param _claimTopic the Claim Topic that has to be checked to know if the `issuer` is allowed to emit it
    *  @return true if the issuer is trusted for this claim topic.
    */
    function hasClaimTopic(address _issuer, uint _claimTopic) external view returns(bool);

   /**
    *  @dev Transfers the Ownership of TrustedIssuersRegistry to a new Owner.
    *  @param _newOwner The new owner of this contract.
    *  This function can only be called by the owner of the Trusted Issuers Registry contract
    *  emits an `OwnershipTransferred` event
    */
    function transferOwnershipOnIssuersRegistryContract(address _newOwner) external;
}
